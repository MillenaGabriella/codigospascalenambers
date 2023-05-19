
                                                                                                                                                                     program Aula26;

                                                                                                                                                                     type placa = array [1..4] of integer;

                                                                                                                                                                       exprn = record
                                                                                                                                                                               texto : string;
                                                                                                                                                                               valor : real;
                                                                                                                                                                               end;

                                                                                                                                                                              a4exp = array [1..4] of exprn;

                                                                                                                                                                              const MAXDIG= 4;

                                                                                                                                                                              var a4num : array [1..24] of placa;
                                                                                                                                                                                control,
                                                                                                                                                                                linha : integer;

                                                                                                                                                                                procedure mistura(input : placa; index : integer);

                                                                                                                                                                                var output : placa;
                                                                                                                                                                                  p, i : integer;

                                                                                                                                                                                  begin
                                                                                                                                                                                    if index=MAXDIG then
                                                                                                                                                                                     begin

                                                                                                                                                                                       a4num[linha] := input;
                                                                                                                                                                                       linha := linha +1;
                                                                                                                                                                                       end
                                                                                                                                                                                       else
                                                                                                                                                                                       begin
                                                                                                                                                                                        output := input;
                                                                                                                                                                                        for p := index to MAXDIG do
                                                                                                                                                                                        begin
                                                                                                                                                                                         output[index] := input[p];
                                                                                                                                                                                         for i := index to p - 1 do
                                                                                                                                                                                           output[i + 1] := input[i];
                                                                                                                                                                                           for i := p + 1 to MAXDIG do
                                                                                                                                                                                            output[i] := input[i];
                                                                                                                                                                                            mistura(output,index + 1);
                                                                                                                                                                                            end;
                                                                                                                                                                                            end;
                                                                                                                                                                                            end;


                                                                                                                                                                                           const DEBUG = FALSE;

                                                                                                                                                                                            procedure showexpr(input : exprn);
                                                                                                                                                                                            begin
                                                                                                                                                                                             writeln('"', input.texto, '" , ',input.valor);
                                                                                                                                                                                             end;


                                                                                                                                                                                             procedure sherror(code : integer);
                                                                                                                                                                                             begin
                                                                                                                                                                                              if (code>0) then
                                                                                                                                                                                              begin
                                                                                                                                                                                              if DEBUG then
                                                                                                                                                                                               case code of
                                                                                                                                                                                                201 :
                                                                                                                                                                                                 writeln('A entrada é inválida. Apenas dígitos, de 0 a 9, são aceitos!');
                                                                                                                                                                                                202 :
                                                                                                                                                                                                 writeln('Divisão por 0!');
                                                                                                                                                                                                 203 :
                                                                                                                                                                                                  writeln('Não posso calcular potência de valor igual ou menor que 0!');
                                                                                                                                                                                                 204 :
                                                                                                                                                                                                  writeln('Sequência númerica mal formatada!'); { erro introduzido pelo test3by1 }
                                                                                                                                                                                                 else
                                                                                                                                                                                                  writeln('Código de controle: ', code);
                                                                                                                                                                                                  end;

                                                                                                                                                                                                  control := 0;
                                                                                                                                                                                                  end;
                                                                                                                                                                                                  end;


                                                                                                                                                                                                  function valn(input : exprn) : exprn;
                                                                                                                                                                                                  var v , w : integer;
			                                                                                                                                                                           begin
			                                                                                                                                                                           if (input.texto >= '0') and (input.texto <= '9') then
			                                                                                                                                                                           begin
			                                                                                                                                                                           val(input.texto,v,w);
			                                                                                                                                                                           if (w=0) then
			                                                                                                                                                                           input.valor := v
			                                                                                                                                                                           else
			                                                                                                                                                                           control := w;
			                                                                                                                                                                            end
				                                                                                                                                                                    else
				                                                                                                                                                                    control := 201;
				                                                                                                                                                                    valn := input;
			                                                                                                                                                                             end;


			                                                                                                                                                                            function dezena(inp1, inp2 : exprn) : exprn;
				                                                                                                                                                                    var v , w : integer;
				                                                                                                                                                                     s : string;
				                                                                                                                                                                    begin
				                                                                                                                                                                    s := inp1.texto + inp2.texto;
				                                                                                                                                                                    val(s, v, w);
				                                                                                                                                                                    if w<>0 then
                                                                                                                                                                                                    begin
                                                                                                                                                                                                      inp1.texto := 'erro';   { padronização do tratamento de erro (aula) }
                                                                                                                                                                                                      inp1.valor := -996;
                                                                                                                                                                                                     control := 204;          { código para sherror() (aula) }
                                                                                                                                                                                                     end
				                                                                                                                                                                    else
				                                                                                                                                                                    begin
				                                                                                                                                                                    inp1.texto := s;
				                                                                                                                                                                    inp1.valor := v;
				                                                                                                                                                                    end;
				                                                                                                                                                                    dezena := inp1;
				                                                                                                                                                                    end;




			                                                                                                                                                                             function nb_add(inp1, inp2 : exprn) : exprn;
				                                                                                                                                                                     begin
				                                                                                                                                                                     inp1.texto := inp1.texto + ' + ' + inp2.texto;
				                                                                                                                                                                     inp1.valor:= inp1.valor + inp2.valor;
				                                                                                                                                                                     nb_add := inp1;
				                                                                                                                                                                     end;

				                                                                                                                                                                      function nb_sub(inp1, inp2 : exprn) : exprn;
				                                                                                                                                                                      begin
				                                                                                                                                                                      inp1.texto := inp1.texto + ' - ' + inp2.texto;
				                                                                                                                                                                      inp1.valor := inp1.valor - inp2.valor;
				                                                                                                                                                                      nb_sub := inp1;
				                                                                                                                                                                      end;

				                                                                                                                                                                       function nb_mul(inp1, inp2 : exprn) : exprn;
				                                                                                                                                                                       begin
				                                                                                                                                                                       inp1.texto := inp1.texto + ' * ' + inp2.texto;
				                                                                                                                                                                       inp1.valor := inp1.valor * inp2.valor;
				                                                                                                                                                                       nb_mul := inp1;
				                                                                                                                                                                       end;

				                                                                                                                                                                        function nb_div(inp1, inp2 : exprn) : exprn;
				                                                                                                                                                                        begin
				                                                                                                                                                                        if (inp2.valor = 0) then
				                                                                                                                                                                        begin
				                                                                                                                                                                        inp1.texto := 'erro';
				                                                                                                                                                                        inp1.valor := -999;
				                                                                                                                                                                        control := 202;
				                                                                                                                                                                        end
				                                                                                                                                                                        else
				                                                                                                                                                                        begin
				                                                                                                                                                                        inp1.texto := inp1.texto + ' / ' + inp2.texto;
				                                                                                                                                                                        inp1.valor := inp1.valor / inp2.valor;
				                                                                                                                                                                        end;
				                                                                                                                                                                        nb_div := inp1;
				                                                                                                                                                                        end;


				                                                                                                                                                                         function nb_idiv(inp1, inp2 : exprn) : exprn;
				                                                                                                                                                                         begin
				                                                                                                                                                                         if (inp2.valor = 0) then
				                                                                                                                                                                         begin
				                                                                                                                                                                         inp1.texto := 'erro';
				                                                                                                                                                                         inp1.valor := -999;
				                                                                                                                                                                         control := 202;
				                                                                                                                                                                         end
				                                                                                                                                                                         else
				                                                                                                                                                                         begin
				                                                                                                                                                                         inp1.texto := inp1.texto + ' \ ' + inp2.texto;
				                                                                                                                                                                         inp1.valor := trunc(inp1.valor) DIV trunc(inp2.valor);
				                                                                                                                                                                         end;
				                                                                                                                                                                         nb_idiv := inp1;
				                                                                                                                                                                         end;

				                                                                                                                                                                          function nb_mod(inp1, inp2 : exprn) : exprn;
				                                                                                                                                                                          begin
				                                                                                                                                                                          if (inp2.valor = 0) then
				                                                                                                                                                                          begin
				                                                                                                                                                                          inp1.texto := 'erro';
				                                                                                                                                                                          inp1.valor := -999;
				                                                                                                                                                                          control := 202;
				                                                                                                                                                                          end
				                                                                                                                                                                          else
				                                                                                                                                                                          begin
				                                                                                                                                                                          inp1.texto := inp1.texto + '  %  ' + inp2.texto;
				                                                                                                                                                                          inp1.valor := trunc(inp1.valor) MOD trunc(inp2.valor);
				                                                                                                                                                                          end;
				                                                                                                                                                                          nb_mod := inp1;
				                                                                                                                                                                          end;

																									function nb_pow(inp1, inp2 : exprn) : exprn;
																									begin
																									if (inp1.valor <= 0) then
																									begin
																									inp1.texto := 'erro';
																									inp1.valor := -997;
																									control := 203;
																									end
																									else
																									begin
																									inp1.texto := inp1.texto + ' ^ ' + inp2.texto;
																									inp1.valor := exp(inp2.valor * ln(inp1.valor));
																									end;
																									nb_pow := inp1;
																									end;


																									function nb_wop(inp1, inp2 : exprn) : exprn;
																									begin
																									if (inp2.valor <= 0) then
																									begin
																									inp1.texto := 'erro';
																									inp1.valor := -997;
																									control := 203;
																									end
																									else
																									if (inp1.valor = 0) then
																									begin
																									inp1.texto := 'erro';
																									inp1.valor := -999;
																									control := 202;
																									end
																									else
																									begin
																									inp1.texto := inp1.texto + ' V ' + inp2.texto;
																									inp1.valor := exp(1/inp1.valor * ln(inp2.valor));
																									end;
																									nb_wop := inp1;
																									end;

																									function nb_min(inp1, inp2 : exprn) : exprn;
																									 begin
																									 inp1.texto := 'min (' + inp1.texto + ' , ' + inp2.texto + ')';

																									 if inp2.valor < inp1.valor then
																									 inp1.valor := inp2.valor;
																									 nb_min := inp1;
																									 end;

																									 function nb_max(inp1, inp2 : exprn) : exprn;
																									 begin
																									 inp1.texto := 'max (' + inp1.texto + ' , ' + inp2.texto + ')';

																									 if inp2.valor > inp1.valor then
																									 inp1.valor := inp2.valor;
																									 nb_max := inp1;
																									 end;

																									 function nb_mid(inp1, inp2 : exprn) : exprn;
																									  begin
																									  inp1.texto := 'mid (' + inp1.texto + ' , ' + inp2.texto + ')';
																									  inp1.valor := (inp1.valor + inp2.valor) / 2;
																									  nb_mid := inp1;
																									  end;




																							function eval2e(i1, i2 : exprn; var ctl : integer) : exprn;
																							begin
																							 inc(ctl);
																							 case ctl of
																							  1 : eval2e := dezena(i1, i2);
																							  2 : eval2e := nb_add(i1, i2);
																							  3 : eval2e := nb_sub(i1, i2);
																								4 : eval2e := nb_mul(i1, i2);
																								5 : eval2e := nb_div(i1, i2);
																								6 : eval2e := nb_idiv(i1, i2);
																								7 : eval2e := nb_mod(i1 , i2);
																								8 : eval2e := nb_pow(i1, i2);
																								9 : eval2e := nb_wop(i1, i2);
																								10 : eval2e := nb_min(i1, i2);
																								11 : eval2e := nb_max(i1, i2);
																								12 : eval2e := nb_mid(i1, i2);
																							  else
																							  ctl := 0;
																							  end;
																							  end;


																							  procedure test2by2(inp : a4exp);
																							  var eleft, eright : exprn;
																							   cleft, cright : integer;

																							   begin

																							    cleft := 0;
																							    repeat
																							     eleft := eval2e(inp[1], inp[2], cleft);

																							     cright :=0;
																							     repeat
																							      eright := eval2e(inp[3],inp[4],cright);

																							      if (cleft>0) and (cright>0) and (eleft.valor = eright.valor) then
																							      writeln('Arranjo ',linha:2, ' => ',eleft.texto,' = ',eright.texto)
																							      else
																							       if control>0 then
																                                                               begin
																							        sherror(control);
																							        end;
																							      until cright = 0;
																							    until cleft = 0;
																							    end;

                                                                                                                                                                                                  procedure test3by1(inp : a4exp);                                    { Implementar o novo procedimento test3by1}
                                                                                                                                                                                                  var eright, epart, eleft : exprn;
                                                                                                                                                                                                  cpart, cleft : integer;

                                                                                                                                                                                                  begin
                                                                                                                                                                                                     {
                                                                                                                                                                                                       não executa o cálculo de eleft se epart não for válido }

                                                                                                                                                                                                  eright := inp[4];

                                                                                                                                                                                                  repeat

                                                                                                                                                                                                  epart := eval2e(inp[1], inp[2], cpart);

                                                                                                                                                                                                  if (cpart>0) and (epart.texto <> 'erro') then

                                                                                                                                                                                                  if length(epart.texto) = 5 then
                                                                                                                                                                                                  epart.texto := '( ' + epart.texto + ') ';

                                                                                                                                                                                                   repeat




                                                                                                                                                                                                  eleft := eval2e(epart, inp[3], cleft);
                                                                                                                                                                                                   if (cleft<>0) and (eleft.valor = eright.valor ) then
                                                                                                                                                                                                  writeln('Arranjo',linha:2, ' => ',eleft.texto,' = ', eright.texto)
                                                                                                                                                                                                  else
                                                                                                                                                                                                     if control>0 then
                                                                                                                                                                                                     begin
                                                                                                                                                                                                    sherror(control);
                                                                                                                                                                                                    end;
                                                                                                                                                                                                    until cleft = 0;
                                                                                                                                                                                                    until cpart = 0;


                                                                                                                                                                                                    end;


        																							    var entrada : string;
                                                                                                                                                                                                    input, prova : a4exp;
                                                                                                                                                                                                    p, i : integer;
                                                                                                                                                                                                    begin

                                                                                                                                                                                                    linha := 1;
                                                                                                                                                                                                    for i := 1 to MAXDIG do
                                                                                                                                                                                                    a4num[linha,i] := i;
                                                                                                                                                                                                    mistura(a4num[linha],1);

                                                                                                                                                                                                    repeat
                                                                                                                                                                                                    write('Entre o número da placa, na forma de uma sequência de quatro dígitos: ');
                                                                                                                                                                                                    readln(entrada);
                                                                                                                                                                                                    if entrada='fim' then
                                                                                                                                                                                                    break;
                                                                                                                                                                                                    for i := 1 to MAXDIG do
                                                                                                                                                                                                    begin
                                                                                                                                                                                                    input[i].texto := entrada[i];
                                                                                                                                                                                                    input[i] := valn(input[i]);
                                                                                                                                                                                                    //showexpr(input[i]);
                                                                                                                                                                                                    end;
                                                                                                                                                                                                    if control = 0 then
                                                                                                                                                                                                    begin
                                                                                                                                                                                                    linha := 1;
                                                                                                                                                                                                    while linha < 19 do
                                                                                                                                                                                                    begin
                                                                                                                                                                                                    for i := 1 to MAXDIG do
                                                                                                                                                                                                    prova[i] := input[a4num[linha][i]];
                                                                                                                                                                                                    { teste de igualdade entre 2 e 2 dígitos }
                                                                                                                                                                                                    test2by2(prova);
                                                                                                                                                                                                    inc(linha);
                                                                                                                                                                                                    if linha>6 then inc(linha);
                                                                                                                                                                                                    end;
                                                                                                                                                                                                    linha := 1;
                                                                                                                                                                                                    repeat
                                                                                                                                                                                                    for i := 1 to MAXDIG do
                                                                                                                                                                                                    prova[i] := input[a4num[linha][i]];
                                                                                                                                                                                                    { teste de igualdade entre 1 e 3 dígitos }
                                                                                                                                                                                                    test3by1(prova);
                                                                                                                                                                                                    inc(linha);
                                                                                                                                                                                                    until linha > 24;
                                                                                                                                                                                                    end;

                                                                                                                                                                                                    if control<>0 then
                                                                                                                                                                                                    sherror(control)
                                                                                                                                                                                                    else
                                                                                                                                                                                                    writeln;
                                                                                                                                                                                                    until FALSE;
                                                                                                      end.                                                                                            end.





