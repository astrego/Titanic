

mod = function(j,n,o,q,t,v,w,msplit,mcp,data)
{
  #Converting the input strings into the right parameters
  arguments <- as.list(match.call())   
  j = eval(arguments$j, data)
  n = eval(arguments$n, data)
  o = eval(arguments$o, data)
  q = eval(arguments$q, data)
  t = eval(arguments$t, data)
  v = eval(arguments$v, data)
  w = eval(arguments$w, data)
  
  model <- rpart(Survived ~j + n + o + q + t + v + w, method="class",data=data,minsplit=msplit,cp=mcp)

}

