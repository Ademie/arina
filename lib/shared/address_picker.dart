import 'package:arina/constants/api_keys.dart';
import 'package:arina/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

class AddressPicker extends StatefulWidget {
  const AddressPicker({
    super.key,
  });

  @override
  State<AddressPicker> createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Address", style: flargeText),
        GooglePlacesAutoCompleteTextFormField(
          countries: const ["us"],
          textEditingController: _textController,
          googleAPIKey: googleMap,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          maxLines: 1,
          debounceTime: 200,
          overlayContainer: (child) => Material(
            elevation: 1.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
          getPlaceDetailWithLatLng: (prediction) {
            print('placeDetails${prediction.lng}, ${prediction.lat}');
          },
          itmClick: (Prediction prediction) =>
              _textController.text = prediction.description!,
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
