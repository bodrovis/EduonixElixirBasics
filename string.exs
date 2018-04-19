string = "Hi!"
# << 1, 1000 >>
string = "hi #{2 * 5}"
IO.inspect string
s_sigils = ~s( hi #{2*5} )
no_int_sigil = ~S( hi #{2*5} )
IO.inspect s_sigils
IO.inspect no_int_sigil
IO.inspect s_sigils <> no_int_sigil
