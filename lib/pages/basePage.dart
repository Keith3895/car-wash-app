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
    // if (AuthService.instance.currentUser?.user_type == null) {
    //   VendorConfirmationModal(context);
    // }
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
                child: BlocConsumer<LogoutCubit, LogoutState>(
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
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<LogoutCubit>().logout();
                    },
                    child: const Text('Logout'),
                  );
                }
              },
            )),
          ),
        ][currentPageIndex]);
  }
}
