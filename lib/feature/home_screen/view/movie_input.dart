import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rotten_chickens/Core/widget/text_form_field_component.dart';
import 'package:rotten_chickens/feature/home_screen/cubit/movie_cubit.dart';
import 'package:rotten_chickens/feature/home_screen/models/movie.dart';

class MovieInput extends StatefulWidget {
  const MovieInput({
    Key? key,
    required this.type,
    this.movie,
  }) : super(key: key);
  final MovieInputType type;
  final Movie? movie;

  @override
  State<MovieInput> createState() => _MovieInputState();
}

class _MovieInputState extends State<MovieInput> {
  @override
  void initState() {
    if (widget.type == MovieInputType.edit) {
      _titleController.text = widget.movie!.title;
      _summaryController.text = widget.movie!.summary;
      _imageController.text = widget.movie!.imageUrl;
    }
    super.initState();
  }

  final GlobalKey<FormState> _titleKey = GlobalKey();
  final GlobalKey<FormState> _summaryKey = GlobalKey();
  final GlobalKey<FormState> _imageKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  bool showError = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton(
      onPressed: () {
        showBottomSheet(
            context: context,
            builder: (_) {
              return Container(
                height: size.height * 0.5,
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height * 0.5,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _titleInput(context),
                              _summaryInput(context),
                              _imageInput(context),
                            ],
                          ),
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            _submit();
                          },
                          child: Container(
                            height: size.width / 8,
                            width: size.width / 2.6,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xff4796ff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.type == MovieInputType.add
                                  ? 'add'
                                  : 'edit',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Icon(
        widget.type == MovieInputType.add ? Icons.add : Icons.edit,
      ),
    );
  }

  Widget _titleInput(BuildContext context) {
    return TextFromFieldComponent(
      formKey: _titleKey,
      controller: _titleController,
      hintText: 'title',
      prefixIconData: Icons.title,
      obscureText: false,
      showErrorMessage: showError,
      suffixIconData: null,
      onChanged: (value) {
        debugPrint(value);
      },
      validator: (value) {
        return value == '' ? 'title tidak boleh kosong' : null;
      },
    );
  }

  Widget _summaryInput(BuildContext context) {
    return TextFromFieldComponent(
      formKey: _summaryKey,
      controller: _summaryController,
      hintText: 'summary',
      prefixIconData: Icons.note,
      obscureText: false,
      showErrorMessage: showError,
      suffixIconData: null,
      onChanged: (value) {},
      validator: (value) {
        return value == '' ? 'summary tidak boleh kosong' : null;
      },
    );
  }

  Widget _imageInput(BuildContext context) {
    return TextFromFieldComponent(
      formKey: _imageKey,
      controller: _imageController,
      hintText: 'image-url',
      prefixIconData: Icons.note,
      obscureText: false,
      showErrorMessage: showError,
      suffixIconData: null,
      onChanged: (value) {},
      validator: (value) {
        return value == '' ? 'image-url tidak boleh kosong' : null;
      },
    );
  }

  void _submit() async {
    widget.type == MovieInputType.add ? await _add() : await _edit();

    Navigator.of(context).pushNamedAndRemoveUntil(
      '/Home',
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _add() async {
    var preference = await SharedPreferences.getInstance();
    var _id = preference.getString('movies')!.length + 1;
    context.read<MovieCubit>().addMovie(
          Movie(
            id: _id,
            title: _titleController.text,
            summary: _summaryController.text,
            imageUrl: _imageController.text,
          ),
        );
  }

  Future<void> _edit() async {
    context.read<MovieCubit>().editMovie(
          Movie(
            id: widget.movie!.id,
            title: _titleController.text,
            summary: _summaryController.text,
            imageUrl: _imageController.text,
          ),
          widget.movie!.id,
        );
  }
}

enum MovieInputType { add, edit }
