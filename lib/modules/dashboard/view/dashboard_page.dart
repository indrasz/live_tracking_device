import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tracking/gen/assets.gen.dart';
import 'package:live_tracking/gen/colors.gen.dart';
import 'package:live_tracking/modules/dashboard/bloc/geolocation/geolocation_bloc.dart';
import 'package:live_tracking/modules/dashboard/bloc/location/location_bloc.dart';
import 'package:live_tracking/modules/login/bloc/login_bloc.dart';
import 'package:live_tracking/modules/login/cubit/form_values_cubit.dart';
import 'package:live_tracking/modules/top_level_bloc/cubit/form_key_cubit.dart';
import 'package:live_tracking/utils/screen_size.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            children: [
              Container(
                alignment: ScreenSize.isBelowExtraLargeScreen(context)
                    ? Alignment.center
                    : Alignment.topLeft,
                child: Assets.images.logoTranstrack.image(width: 180),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  runSpacing: 40,
                  spacing: 40,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8),
                    //   child: Container(
                    //     width: ScreenSize.isBelowExtraLargeScreen(context)
                    //         ? double.infinity
                    //         : MediaQuery.of(context).size.width * 0.3,
                    //     padding: const EdgeInsets.all(20),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(34),
                    //     ),
                    //     child: const _FormBodyWidget(),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: ScreenSize.isBelowExtraLargeScreen(context)
                            ? double.infinity
                            : MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(34),
                        ),
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  GeolocationBloc()..add(LoadGeolocation()),
                            ),
                          ],
                          child: const _FormBodyWidget(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(
                            width: ScreenSize.isBelowExtraLargeScreen(context)
                                ? double.infinity
                                : MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                SelectableText(
                                  'RegisT',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                const SelectableText(
                                  'Pengelolaan device dan pemantauan pemasangan device\nTranstrack.ID',
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Assets.images.illustrationLogin.svg(width: 120)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: ColorName.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          height: 48,
          child: Text(
            '© 2019-${DateTime.now().year}. PT. Indo Trans Teknologi. All rights reserved',
            style: const TextStyle(color: ColorName.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _FormBodyWidget extends StatelessWidget {
  const _FormBodyWidget({Key? key}) : super(key: key);

  // void _submit(BuildContext context) {
  //   final formKey = context.read<FormKeyCubit>().state;

  //   if (!formKey.currentState!.validate()) return;

  //   final values = context.read<FormValuesCubit>().state;

  //   context.read<LoginBloc>().add(
  //         LoginSubmitEvent(
  //           email: values.email,
  //           password: values.password,
  //         ),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    // final isVisible = context.watch<VisibilityPasswordCubit>().state;

    return BlocBuilder<GeolocationBloc, GeolocationState>(
      builder: (context, state) {
        if (state is GeolocationLoadedSuccess) {
          return Center(
            child: Column(
              children: [
                Text(
                  'Latitude : ${state.position.latitude.toString()}',
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  'Longitude : ${state.position.longitude.toString()}',
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  'Altitude : ${state.position.altitude.toString()}',
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  'Speed : ${state.position.speed.toString()}',
                  style: TextStyle(color: Colors.red),
                ),

                Text(
                  'Timestamp : ${state.position.timestamp.toString()}',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        } else if (state is GeolocationLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          return const Center(
            child: Text('TOLOOOOOOL'),
          );
        }
      },
    );

//     return Form(
//       // key: context.read<FormKeyCubit>().state,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Text(
//                     'Send Telematic Data',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 40),
//                   Container(
//                     padding: const EdgeInsets.only(
//                       bottom: 8,
//                       top: 8,
//                     ),
//                     child: const Text(
//                       'Altitude ',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     // initialValue: context.read<FormValuesCubit>().state.email,
//                     // validator: (value) {
//                     //   if (value != null && value.isEmpty) {
//                     //     return 'Email tidak boleh kosong';
//                     //   }
//                     //   return null;
//                     // },
//                     decoration: const InputDecoration(
//                       hintText: 'Masukan Altitude..',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide: BorderSide(color: Colors.black54),
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       // for below version 2 use this
//                       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// // for version 2 and greater youcan also use this
//                       FilteringTextInputFormatter.digitsOnly
//                     ],
//                     // onChanged: (email) {
//                     //   // context.read<FormValuesCubit>().setEmail(email);
//                     // },
//                     // onFieldSubmitted: (value) => _submit(context),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     'Bearing',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     // initialValue:
//                     //     context.read<FormValuesCubit>().state.password,
//                     // validator: (value) {
//                     //   if (value != null && value.isEmpty) {
//                     //     return 'Password tidak boleh kosong';
//                     //   }
//                     //   return null;
//                     // },
//                     // obscureText: !isVisible,
//                     decoration: const InputDecoration(
//                       hintText: 'Masukan Bearing..',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide: BorderSide(color: Colors.black54),
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       // for below version 2 use this
//                       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// // for version 2 and greater youcan also use this
//                       FilteringTextInputFormatter.digitsOnly
//                     ],
//                     // onChanged: (password) {
//                     //   // context.read<FormValuesCubit>().setPassword(password);
//                     // },
//                     // onFieldSubmitted: (value) => _submit(context),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     'Ion',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     // initialValue:
//                     //     context.read<FormValuesCubit>().state.password,
//                     // validator: (value) {
//                     //   if (value != null && value.isEmpty) {
//                     //     return 'Password tidak boleh kosong';
//                     //   }
//                     //   return null;
//                     // },
//                     // obscureText: !isVisible,
//                     decoration: const InputDecoration(
//                       hintText: 'Masukan Ion..',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide: BorderSide(color: Colors.black54),
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       // for below version 2 use this
//                       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// // for version 2 and greater youcan also use this
//                       FilteringTextInputFormatter.digitsOnly
//                     ],
//                     // onChanged: (password) {
//                     //   // context.read<FormValuesCubit>().setPassword(password);
//                     // },
//                     // onFieldSubmitted: (value) => _submit(context),
//                   ),

//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     'HDOP',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     // initialValue:
//                     //     context.read<FormValuesCubit>().state.password,
//                     // validator: (value) {
//                     //   if (value != null && value.isEmpty) {
//                     //     return 'Password tidak boleh kosong';
//                     //   }
//                     //   return null;
//                     // },
//                     // obscureText: !isVisible,
//                     decoration: const InputDecoration(
//                       hintText: 'Masukan HDOP..',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide: BorderSide(color: Colors.black54),
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       // for below version 2 use this
//                       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// // for version 2 and greater youcan also use this
//                       FilteringTextInputFormatter.digitsOnly
//                     ],
//                     // onChanged: (password) {
//                     //   // context.read<FormValuesCubit>().setPassword(password);
//                     // },
//                     // onFieldSubmitted: (value) => _submit(context),
//                   ),

//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     'Lat',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     // initialValue:
//                     //     context.read<FormValuesCubit>().state.password,
//                     // validator: (value) {
//                     //   if (value != null && value.isEmpty) {
//                     //     return 'Password tidak boleh kosong';
//                     //   }
//                     //   return null;
//                     // },
//                     // obscureText: !isVisible,
//                     decoration: const InputDecoration(
//                       hintText: 'Masukan Lat..',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         borderSide: BorderSide(color: Colors.black54),
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       // for below version 2 use this
//                       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// // for version 2 and greater youcan also use this
//                       FilteringTextInputFormatter.digitsOnly
//                     ],
//                     // onChanged: (password) {
//                     //   // context.read<FormValuesCubit>().setPassword(password);
//                     // },
//                     // onFieldSubmitted: (value) => _submit(context),
//                   ),
//                   const SizedBox(
//                     height: 26,
//                   ),

//                   const SizedBox(height: 28),
//                   Container(
//                     height: 55,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           spreadRadius: 10,
//                           blurRadius: 20,
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         BlocProvider.of<GeolocationBloc>(context).add(
//                           LoadGeolocation(),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: ColorName.primary,
//                         onPrimary: ColorName.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: const SizedBox(
//                         width: double.infinity,
//                         height: 55,
//                         child: Center(
//                           child: Text(
//                             'Send',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // BlocBuilder<LoginBloc, LoginState>(
//                   // builder: (context, state) {
//                   //   if (state is LoginLoading) {
//                   //     return const SizedBox(
//                   //       height: 55,
//                   //       child: Center(
//                   //         child: CircularProgressIndicator(),
//                   //       ),
//                   //     );
//                   //   }
//                   //   return Container(
//                   //     height: 55,
//                   //     decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(30),
//                   //       boxShadow: const [
//                   //         BoxShadow(
//                   //           color: Colors.black12,
//                   //           spreadRadius: 10,
//                   //           blurRadius: 20,
//                   //         ),
//                   //       ],
//                   //     ),
//                   //     child: ElevatedButton(
//                   //       onPressed: (){},
//                   //       style: ElevatedButton.styleFrom(
//                   //         primary: ColorName.primary,
//                   //         onPrimary: ColorName.white,
//                   //         shape: RoundedRectangleBorder(
//                   //           borderRadius: BorderRadius.circular(15),
//                   //         ),
//                   //       ),
//                   //       child: const SizedBox(
//                   //         width: double.infinity,
//                   //         height: 55,
//                   //         child: Center(child: Text('Login')),
//                   //       ),
//                   //     ),
//                   //   );
//                   // },
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
  }
}
