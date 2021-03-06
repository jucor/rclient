--[[ FIRST: 
start a local R session via Rserve, install the Rserve package via the R
package manager and use the following R code: 
    library(Rserve)
    Rserve()

Please refer to the Rserve documentation informations on how to use a different port number and/or enable remote connections. The following code snippet is intended to give an idea of the functionalities that are offered by this library.
--]]


local R = require "rclient"
 
local r = R.connect() -- Connect to a local R session.
 
-- Set v in the R session to a R vector with elements 1,2,3.
r.v = { 1, 2, 3 }
 
-- Execute commands on the r session:
r "v <- v^2" -- Square v.
r "v" --> [1] 1 4 9
 
local vb = r.v -- Retrieve v from the r session.
print(vb[1], vb[2], vb[3]) --> 1, 4, 9
 
-- Aside from R vectors, other R data structures are supported:
r.l = R.list({ "a", "b", "c" }, { 3, 5, 7 })
r.d = R.dataframe({ "a", "b", "c" }, { 3, 5, 7 }, { "row1" })
r.m = R.matrix({ { 1, 2, 3 }, { 4, 5, 6 } })
 
-- Helper functions are available to manipulate data from R:
local map = R.tomap(r.l) -- Indexing via ids instead of numbers.
print(map.a[1], map.b[1], map.c[1]) --> 3, 5, 7
local arr2d = R.to2darray(r.m) -- Array of array.
print(unpack(arr2d[1])) --> 1, 2, 3
print(unpack(arr2d[2])) --> 4, 5, 6