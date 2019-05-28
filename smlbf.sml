datatype bf = INC | DEC | NXT | PRV | PUT | GET | RPT of bf list

fun parse str =
    let infix <>>
	fun op <>> (x, (xs, y)) = (x::xs, y)
	fun parse' [] = ([], [])
	  | parse' (c::cs) =
	    case c of #"+" => INC <>> parse' cs
		    | #"-" => DEC <>> parse' cs
		    | #">" => NXT <>> parse' cs
		    | #"<" => PRV <>> parse' cs
		    | #"," => GET <>> parse' cs
		    | #"." => PUT <>> parse' cs
		    | #"[" => let val p = parse' cs
			      in RPT (#1 p) <>> (parse' o #2) p
			      end
		    | #"]" => ([], cs)
		    | _ => parse' cs
    in (#1 o parse' o explode) str
    end

fun run bs =
    let fun run' (INC :: bs) (xs, y, zs) = run' bs (xs, y+1, zs)
	  | run' (DEC :: bs) (xs, y, zs) = run' bs (xs, y-1, zs)
	  | run' (NXT :: bs) (xs, y, []) = run' bs (y::xs, 0, [])
	  | run' (NXT :: bs) (xs, y, z::zs) = run' bs (y::xs, z, zs)
	  | run' (PRV :: bs) ([], y, zs) = run' bs ([], 0, y::zs)
	  | run' (PRV :: bs) (x::xs, y, zs) = run' bs (xs, x, y::zs)
	  | run' (GET :: bs) (xs, y, zs) =
	    let val getChar = (valOf o TextIO.input1) TextIO.stdIn
	    in run' bs (xs, ord getChar, zs)
	    end
	  | run' (PUT :: bs) (xs, y, zs) =
	    let val m = (print o implode) [chr y]
	    in run' bs (xs, y, zs)
	    end
	  | run' (RPT bs' :: bs) (xs, y, zs) =
	    if y = 0 then run' bs (xs, y, zs)
	    else run' (bs' @ RPT bs' :: bs) (xs, y, zs)
	  | run' [] (xs, y, zs) = (xs, y, zs)
    in ignore  (run' bs ([], 0, []))
    end

fun main () =
    case CommandLine.arguments () of
	[fileName] => (run o parse o TextIO.inputAll o TextIO.openIn) fileName
      | _ => print ("usage: " ^ CommandLine.name () ^ " FileName\n")

val _ = main ()
val _ = OS.Process.exit(OS.Process.success)
