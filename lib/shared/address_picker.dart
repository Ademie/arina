import 'package:homeradar/constants/api_keys.dart';
import 'package:homeradar/constants/constants.dart';
import 'package:homeradar/providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:provider/provider.dart';

class AddressPicker extends StatefulWidget {
  const AddressPicker({
    super.key,
    required this.textEditingController,
  });
  final TextEditingController textEditingController;

  @override
  State<AddressPicker> createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Address", style: flargeText),
        Consumer<AddressProvider>(builder: (context, addressProvider, _) {
          return GooglePlacesAutoCompleteTextFormField(
              countries: const ["us"],
              textEditingController: widget.textEditingController,
              googleAPIKey: googleMap,
              decoration: const InputDecoration(
                hintText: "10 summerville road"
              ),
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
                addressProvider.setDetails(double.parse(prediction.lat!),
                    double.parse(prediction.lng!), prediction.description!);
              },
              itmClick: (Prediction prediction) {
                widget.textEditingController.text = prediction.description!;
              });
        }),
        const SizedBox(height: 25),
      ],
    );
  }
}
