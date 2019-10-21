using Gadfly, Colors

function tpplot(bha::Dict, wob::Int64)
  local tps
  fw(el) = el.wob == Int(wob*1000)
  tps = filter(fw, bha[:tptable])
  nrows = size(tps, 1)
  ranges = zeros(Int64, nrows, 2)
  firstindex = 1
  lastindex = 1
  nextentry = 1
  for i in 1:nrows
    for j in lastindex:nrows
      #println([i j firstindex lastindex])
      if tps[firstindex].inclination == tps[j].inclination
        lastindex = j
      else
        ranges[i,:] = [firstindex lastindex]
        firstindex = j
        lastindex = j + 1
        nextentry = i + 1
        break
      end
    end
  end
  ranges[nextentry,:] = [firstindex lastindex]
  ranges = ranges[1:nextentry, :]
  
  szr = size(ranges, 1)
  cm = distinguishable_colors(szr)
  dalpha = zeros(szr, 10)
  fbit = zeros(szr, 10)
  len = zeros(Int64, szr, 1)
  incl = zeros(Int64, szr, 1)

  for i in 1:size(ranges, 1)
    r = collect(ranges[i, 1]:ranges[i, 2])
    indx = 1
    for j in r
      dalpha[i,indx] = tps[j].dalpha
      fbit[i,indx] = tps[j].fbit
      len[i] = Int(ranges[i, 2] - ranges[i, 1] + 1)
      incl[i] = tps[j].inclination
      indx += 1
    end
  end
  p = plot(
    [layer(x = dalpha[i, 1:len[i]], y = fbit[i, 1:len[i]], 
      Geom.line, Theme(default_color=cm[i])) for i=1:szr]...,
    [layer(x = dalpha[i, 1:len[i]], y = fbit[i, 1:len[i]], 
      Geom.point, Theme(default_color=cm[i])) for i=1:szr]...,
    Guide.manual_color_key("Settings", ["incl:$(incl[i])" for i=1:szr], cm),
    Guide.xlabel("tp"), Guide.ylabel("Force at the bit"), 
    Guide.title("Theoretical Performance\n    at WOB = $(wob) klb")
  )
  p
end

function nbsplot(bha::Dict)
  plots = Gadfly.Plot[]
  wobs = collect(bha[:wobrange])
  szr = length(wobs)
  cm = distinguishable_colors(szr)
  df = BoreHoleAssemblyAnalysis.runs2df(bha)
  plot(
    [layer(df[df[:wob] .== wobs[i], :], x=:inclination, y=:f_firsttouch, 
      Geom.line, Theme(default_color=cm[i])) for i=1:szr]...,
    [layer(df[df[:wob] .== wobs[i], :], x=:inclination, y=:f_firsttouch, 
      Geom.point, Theme(default_color=cm[i])) for i=1:szr]...,
    Guide.manual_color_key("Settings", ["wob:$(wobs[i])" for i=1:szr], cm),
    Guide.xlabel("inclination"), Guide.ylabel("Force at point of first touch"), 
    Guide.title("Force vs. inclination")
  )
end

function showplots(bha::Dict)
  wobs = collect(bha[:wobrange])
  for wob in wobs
    tp = tpplot(bha, wob)
    nbs = nbsplot(bha::Dict)
    filename = "tp_wob_$(wob).pdf"
    draw(PDF(filename, 6inch, 9inch), vstack(hstack(tp, nbs), hstack(tp)))
  end
end