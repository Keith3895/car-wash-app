import 'package:car_wash/blocs/login/login_bloc.dart';
import 'package:car_wash/blocs/onboard/onboard_bloc.dart';
import 'package:car_wash/cubits/logout/logout_cubit.dart';
import 'package:car_wash/services/auth_service.dart';
import 'package:car_wash/widgets/loginWidgets/vendorConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class basePage extends StatefulWidget {
  const basePage({super.key});

  @override
  State<basePage> createState() => basePageState();
}

class basePageState extends State<basePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (AuthService.instance.currentUser?.user_type == null) {
      context.read<LoginBloc>().emit(const NoUserType(message: 'from base page'));
    } else if (AuthService.instance.currentUser?.user_type == 2) {
      context.read<OnboardBloc>().add(const getVendorDetails());
    }
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_filled),
                label: 'Home'),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month_rounded),
              label: 'Appointments',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Saved',
            ),
          ],
        ),
        body: <Widget>[
          Container(
            child: Center(
                child: MultiBlocListener(
              listeners: [
                BlocListener<LogoutCubit, LogoutState>(
                  listener: (context, state) => {
                    if (state is LogoutSuccess)
                      {
                        AuthService.instance.terminate(),
                        Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false)
                      }
                    else if (state is LogoutFailure)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            duration: const Duration(seconds: 2),
                          ),
                        )
                      }
                  },
                ),
                BlocListener<LoginBloc, LoginState>(listener: (context, state) {
                  if (state is NoUserType) {
                    VendorConfirmationModal(context);
                  }
                  if (state is AddUserTypeSuccess) {
                    if (AuthService.instance.currentUser?.user_type == 2) {
                      Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
                    }
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  }
                }),
                BlocListener<OnboardBloc, OnboardState>(listener: (context, state) {
                  if (state is NoVendorDetails) {
                    Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
                  }
                  if (state is OnboardError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                })
              ],
              child: ElevatedButton(
                onPressed: () {
                  context.read<LogoutCubit>().logout();
                },
                child: const Text('Logout'),
              ),
            )),
          ),
        ][currentPageIndex]);
  }
}
