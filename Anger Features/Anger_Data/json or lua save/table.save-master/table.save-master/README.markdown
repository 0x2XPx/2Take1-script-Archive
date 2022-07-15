## Save Table To File

**Note:** Originally this code is located at http://lua-users.org/wiki/SaveTableToFile
This version changes 3 variables to local at function `table.load` to make it compatible with `strict.lua`. Thanks to nat12 for suggestion.

---

Save a Table to a string or file; Load a Table from string or file
Since building a string from a big table uses more time than saving the table to file and loading it from there, one should use table.save( table, true ) to get the stringtable from a big table

Characteristics:

* Userdata is not saved.
* Functions are saved via string.dump, so make sure it has no upvalues.
* References are saved.

NOTICE: NOT suitable for huge tables. Saving a table containing 100.000 subtables with 25 (1 short text line and 24 numerical entries) fields works. Somewhere above that performance is disastrous when saving. And you get an "constant table overflow" error when you try to read it back. With smaller tables it seems to work. Especially considering it is a cut and past solution to your need.

Testcode


  
	function Main()
		 
	dofile( "table.save-0.94.lua" )

	print( "//Serialise Test ..." )
	print( "//Building Table ..." )
		
	local t = {}
	t.a = 1
	t.b = 2
	t.c = {}
	-- self reference
	t.c.a = t
	t.inass = { 1,2,3,4,5,6,7,8,9,10 }
	t.inasst = { {1},{2},{3},{4},{5},{6},{7},{8},{9},{10} }
	-- random
	t.f = { [{ a = 5, b = 7, }] = "helloooooooo", [{ 1,2,3, m = 5, 5,6,7 }] = "A Table", }
	t.func = function(x,y)
		print( "Hello\nWorld" )
		local sum = x+y
		return sum
	end
	-- get test string, not string.char(26)
	local str = ""
	for i = 0, 255 do
	   --str = str.." "..i..": "..string.char( i )
	   str = str..string.char( i )
	end
	t.lstri = { [str] = 1 }
	t.lstrv = str

		
	print( "\n## BEFORE SAVE ##" )

	printtbl( t )

	--// test save to file
	assert( table.save( t, "test.tbl" ) == 1 )
		
	--// test save to string
	local strtbl = table.save( t )

	--// test save to string over file
	local strtbl2 = table.save( t, true )
		
	-- load table from file
	local t2 = table.load( "test.tbl" )

	-- load table from string 1	
	local t3 = table.load( strtbl )

	-- load table from string 2
	local t4 = table.load( strtbl2 )

	print( "\n## AFTER SAVE ##" )

	print( "\n## LOAD FROM FILE ##" )
	printtbl( t2 )

	print( "\n## LOAD FROM STRING ##" )
	--printtbl( t3 )

	print( "\n## LOAD FROM STRING OVER FILE ##" )
	--printtbl( t4 )

	print( "\n//Test References" )
		
	assert( t2.c.a == t2 )
	assert( t3.c.a == t3 )
	assert( t4.c.a == t4 )
		
	print( "\n//Test Long string" )

	assert( t.lstrv == t2.lstrv )
	assert( t.lstrv == t3.lstrv )
	assert( t.lstrv == t4.lstrv )

	print( "\n//Test Function\n\n" )

	assert( t2.func(2,2) == 4 )
	assert( t3.func(2,3) == 5 )
	assert( t4.func(2,3) == 5 )

	print( "\n*** Test SUCSESSFULL ***" )

	end

	function printtbl( t,tab,lookup )
		local lookup = lookup or { [t] = 1 }
		local tab = tab or ""
		for i,v in pairs( t ) do
			print( tab..tostring(i), v )
			if type(i) == "table" and not lookup[i] then
				lookup[i] = 1
				print( tab.."Table: i" )
				printtbl( i,tab.."\t",lookup )
			end
			if type(v) == "table" and not lookup[v] then
				lookup[v] = 1
				print( tab.."Table: v" )
				printtbl( v,tab.."\t",lookup )
			end
		end
	end

	Main()
