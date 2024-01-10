import 'package:car_wash/services/permissionUtils.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key, required this.address});
  final TextEditingController address;
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  TextEditingController address = TextEditingController();
  CameraPosition? cameraPosition;
  Position? _currentPos;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    address = widget.address;
  }

  _getCurrentLocation() async {
    await PermissionUtils.managePermissions(
      context: context,
      permissions: [Permission.locationWhenInUse],
      onGranted: () async {
        _currentPos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _pageThree();
  }

  Widget _pageThree() {
    PermissionUtils.managePermissions(
      context: context,
      permissions: [Permission.locationWhenInUse],
      onGranted: () {},
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        googleMap(),
        const SizedBox(
          height: 10,
        ),
        InputField(
          key: const Key('Address'),
          labelText: "Address",
          controller: address,
        ),
      ]),
    );
  }

  Widget googleMap() {
    return SizedBox(
        // width: 400,
        height: 300,
        child: LayoutBuilder(builder: (context, constraints) {
          var maxWidth = constraints.biggest.width;
          var maxHeight = constraints.biggest.height;

          return Stack(
            children: [
              _googleMap(),
              Positioned(
                top: maxHeight * 0.5,
                left: maxWidth * 0.5,
                child: const Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          );
        }));
  }

  Widget _googleMap() {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: const CameraPosition(
        target: LatLng(0, 0),
        zoom: 11.0,
      ),
      onMapCreated: (controller) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(_currentPos!.latitude, _currentPos!.longitude), zoom: 15.0),
          ),
        );
      },
      gestureRecognizers: //
          <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      mapToolbarEnabled: true,
      myLocationEnabled: true,
      onCameraMove: (CameraPosition cameraPositiona) {
        setState(() {
          cameraPosition = cameraPositiona;
        }); //when map is dragging
      },
      onCameraIdle: () async {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              cameraPosition!.target.latitude, cameraPosition!.target.longitude,
              localeIdentifier: 'en_IN');
          setState(() {
            //get place name from lat and lang
            address.text = placemarks.first.subLocality! +
                ',' +
                placemarks.first.locality.toString() +
                ", " +
                placemarks.first.administrativeArea.toString() +
                ", " +
                placemarks.first.postalCode.toString();
          });
        } catch (e) {
          print("------------error---------");
          print(e);
        }
      },
    );
  }
}
