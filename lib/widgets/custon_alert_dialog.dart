import 'package:flutter/material.dart';
import 'package:studywithme/styles/theme_config.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String? titulo;
  final String mensagem;
  final String primeiraOpcao;
  final IconData? iconePrimeiraOpcao;
  final VoidCallback sePrimeiraOpcaoClica;
  final String segundaOpcao;
  final IconData? iconeSegundaOpcao;
  final VoidCallback seSegundaOpcaoClica;

  const CustomConfirmationDialog({
    super.key,
    this.titulo,
    required this.mensagem,
    required this.primeiraOpcao,
    this.iconePrimeiraOpcao,
    required this.sePrimeiraOpcaoClica,
    required this.segundaOpcao,
    this.iconeSegundaOpcao,
    required this.seSegundaOpcaoClica,
    required this.showPrimeiroBotao,
    required this.showSegundoBotao,
  });

  final bool showPrimeiroBotao;
  final bool showSegundoBotao;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 360,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                top: 24,
                bottom: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      titulo ?? 'Atenção!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ThemeConfig.cinzaEscuro,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      mensagem,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: ThemeConfig.cinzaEscuro,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (showPrimeiroBotao)
                      Expanded(
                        child: MaterialButton(
                          onPressed: sePrimeiraOpcaoClica,
                          color: ThemeConfig.cinzaMedio,
                          height: 60,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                showSegundoBotao
                                    ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                    )
                                    : const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (iconePrimeiraOpcao != null)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      iconePrimeiraOpcao,
                                      color: ThemeConfig.cinzaEscuro,
                                    ),
                                  ),
                                Text(
                                  primeiraOpcao,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: ThemeConfig.cinzaEscuro,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (showSegundoBotao)
                      Expanded(
                        child: MaterialButton(
                          onPressed: seSegundaOpcaoClica,
                          color: ThemeConfig.tema.primaryColor,
                          height: 60,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                showPrimeiroBotao
                                    ? const BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                    )
                                    : const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (iconeSegundaOpcao != null)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      iconeSegundaOpcao,
                                      color: ThemeConfig.branco,
                                    ),
                                  ),
                                Text(
                                  segundaOpcao,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: ThemeConfig.branco,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
    );
  }
}
