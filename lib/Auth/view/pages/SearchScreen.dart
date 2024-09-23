import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/core/bloc/bloc/airport_bloc_bloc.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AirportBlocBloc airportBloc = BlocProvider.of<AirportBlocBloc>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromRGBO(247, 247, 249, 1),
                maxRadius: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 19,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Spacer(),
              const Text(
                'Search',
                style: TextStyle(
                  fontFamily: 'SF UI Display',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  airportBloc.add(FetchAirportsEvent());
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  airportBloc.add(ClearSearchEvent());
                } else {
                  airportBloc.add(SearchAirportsEvent(value));
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.mic),
                hintText: 'Search Places',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Search Places',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<AirportBlocBloc, AirportBlocState>(
              builder: (context, state) {
                if (state is AirportBlocLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AirportBlocLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.airports.length,
                      itemBuilder: (context, index) {
                        return PlaceCard(airport: state.airports[index]);
                      },
                    ),
                  );
                } else if (state is AirportBlocError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('No results found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final AirportModel airport;

  PlaceCard({required this.airport});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: 
                 Image.asset(
                    'assets/images/destination.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              airport.name.length > 20
                  ? '${airport.name.substring(0, 20)}...'
                  : airport.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text(airport.city),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
