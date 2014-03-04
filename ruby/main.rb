# encoder class
class Zoundex

    # static lookup table
    @@lookup_table = 
    {
        "b" => 1, "f" => 1, "p" => 1, "v" => 1,
        "c" => 2, "g" => 2, "j" => 2, "k" => 2, "q" => 2, "s" => 2, "x" => 2, "z" => 2,
        "d" => 3, "t" => 3,
        "l" => 4,
        "m" => 5, "n" => 5,
        "r" => 6
    }

    attr_accessor :encoded

    # constructor
    def initialize( name, length )
        
        s = name.downcase

        enc = s[0]

        ( 1..(s.length-1) ).each do |i|
            c = ( @@lookup_table.has_key? s[i] ) ? @@lookup_table[s[i]] : 0
            i = enc.length - 1
            if enc[i] != c
                enc += "#{c}"
            end
        end

        enc2 = ""
        drop = 0

        ( 1..(enc.length-1) ).each do |i|

            a, n, b = enc[i], enc[i+1], enc[i+2]

            if drop > 0
                drop -= 1
            else
                enc2 += a

                if ! n.nil? && n == "0" && ! b.nil? && a == b
                    drop = 2
                end
            end
        end

        @encoded = ((enc.upcase)[0] + enc2.delete( "0" ))
        if length > 0
            @encoded = @encoded.slice( 0..(length-1) )
        end
    end
end

# program
if ARGV.empty?
    puts "no input given!"
else
    check_eq = false
    full_number = false

    values = []
    is_eq = true

    ARGV.each do |arg|
        if arg == "-eq"
            check_eq = true
        elsif arg == "-F"
            full_number = true
        else     
            values.push( Zoundex.new( arg, (full_number ? 0 : 4) ) )
            l = values.length
            if l > 1
                is_eq = is_eq && (values[l-1].encoded == values[l-2].encoded)
            end
        end
    end

    if check_eq
        print "eq:#{is_eq} #{values.last.encoded}"
    else
        values.each do |v|
            print "#{v.encoded} "
        end
    end

    print "\n"
end
