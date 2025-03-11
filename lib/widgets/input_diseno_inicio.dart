import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputDisenoInicio extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? valorInicial;
  final IconData? icon;
  IconData? suffixIcon;
  final TextInputType? keyboardType;
  bool obscureText;
  final String propiedad;
  final Map<String, String> formValues;
  final TextEditingController? controlador;

  InputDisenoInicio({
    super.key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.propiedad,
    required this.formValues,
    this.valorInicial,
    this.controlador,
  });

  @override
  State<InputDisenoInicio> createState() => _InputDisenoInicioState();
}

class _InputDisenoInicioState extends State<InputDisenoInicio> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: const Color.fromRGBO(18, 34, 23, 0.859),
        controller: widget.controlador,
        autofocus: false,
        initialValue: widget.valorInicial,
        textCapitalization: TextCapitalization.words,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: (value) => widget.formValues[widget.propiedad] = value,
        validator: (value) {
          if (value == null) return 'este campo es requerido';
          return value.length < 2 ? 'Campo obligatorio' : null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,

          //prefixIcon: Icon(Icons.verified_user_outlined),
          suffixIcon: widget.suffixIcon == null
              ? null
              : IconButton(
                  icon: Icon(widget.suffixIcon),
                  onPressed: () {
                    if (widget.obscureText == true) {
                      widget.suffixIcon = Icons.visibility;
                      widget.obscureText = false;
                    } else {
                      widget.suffixIcon = Icons.visibility_off;
                      widget.obscureText = true;
                    }

                    setState(() {});
                  },
                ),
          icon: widget.icon == null ? null : Icon(widget.icon),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(10),
          //       topRight: Radius.circular(10)),
          // )
          //counterText: '3 carácteres'),
          floatingLabelStyle: const TextStyle(
            color: Color.fromRGBO(18, 34, 23, 0.859),
          ),
          focusColor: const Color.fromARGB(228, 225, 230, 253),

          suffixIconColor: const Color.fromRGBO(18, 34, 23, 0.859),

          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromRGBO(18, 34, 23, 0.859),
          )),

          fillColor: const Color.fromRGBO(18, 34, 23, 0.859),
        ));
  }
}
