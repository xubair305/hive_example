# hive_example
## Getting Started


// ************************************** Hive Instruction by XBR *****************************//


[NOTE]: I use flutter 3.3.0

Step 1 - add all dependencies in pubspec.yaml
        dependencies
            hive : ^[latest]
            hive_flutter : ^[latest]
            path_provider: ^[latest]
        
        dev_dependencies:
            hive_generator: ^[latest]
            build_runner: ^[latest]

Step 2 - add these lines in gradle.properties

        org.gradle.jvmargs=-Xmx1536M
        android.enableR8=true
        android.useAndroidX=true
        android.enableJetifier=true

Step 3- add this line in main() 
  
        WidgetsFlutterBinding.ensureInitialized();
        await Hive.initFlutter();
        
        

Step 4 - create a model class to generate hive annotations

    for example - data_model.dart
            
            import 'package:hive/hive.dart';

            @HiveType(typeId: 0)
            class DataModel{
            @HiveField(0)
            final String? title;
            @HiveField(1)
            final String? description;
            @HiveField(2)
            final bool? complete;

            DataModel({this.title, this.description, this.complete});
            }

Step 5- run this command in terminal

        flutter packages pub run build_runner build
        
        [Note]: If these command not run first run flutter clean and then flutter pub get


Step 6 - add this lines in main()

        Hive.registerAdapter(DataModelAdapter());
        await Hive.openBox<DataModel>('data');

        [NOTE]: DataModelAdapter() is generated Method and it's name based on your model class name
        [NOTE]: 'data' is the box name where we can store values

Step 7 - create UI part with submit button

Step 8 - make sure every time we close the hive box in dispose method

        Hive.box('data').close();

Step 9 - add data in DB by using box.add()

Step 10 - use ValueListenableBuilder for fetch data from DB