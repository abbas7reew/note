import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/constants.dart';
import 'package:notes/cubits/mode_cubit/mode_cubit.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/models/ModeClass.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/simple_bloc_observer.dart';
import 'package:notes/views/login_page.dart';
import 'package:notes/views/notes_view.dart';
import 'package:notes/views/resgister_page.dart';


import 'cubits/notes_cubit/notes_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => NotesCubit(),),
      BlocProvider(
        create: (context) => ModeCubit(),),
    ],


      child: Builder(
          builder: (context) {
            return BlocProvider(
              create: (context) => ModeCubit(),
              child: Builder(
                  builder: (context) {
                    return BlocBuilder<ModeCubit, ModeState>(
                      builder: (context, state) {
                        return MaterialApp(
                          theme: BlocProvider
                              .of<ModeCubit>(context)
                              .isLight ? ModeClass.lightMode : ModeClass
                              .darkMode,
                          routes: {
                            LoginPage.id: (context) => LoginPage(),
                            RegisterPage.id: (context) => RegisterPage(),
                            NotesView.id: (context) => NotesView()
                          },
                          initialRoute: LoginPage.id,
                          debugShowCheckedModeBanner: false,
                          // theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),

                        );
                      },
                    );
                  }
              ),
            );
          }
      ),
    );
  }
}
