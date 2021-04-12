# Flutter Get Fire

## Getting Started

Use this command to run flutter project 

>flutter run


## Features

### Project Structure
```yaml
- /app  
# This is where all the application's directories will be contained  
    - /data    
        - /services                     
            - /example_service.dart
                - service.dart
                - repository.dart
        - /provider
        # local database of firebase.
            - firestore_provider.dart            
            - firestorage_provider.dart        
        - /model        
            - model.dart
    - /ui
        - /my_page
            - page.dart                        
            - /local_widgets

    - /global_widgets 
    # Widgets that can be reused by multiple **pages**.  

    - /routes        
        - routes.dart                
        - pages.dart        
    - /core
        - /theme
            - app_text.dart
            - app_colors.dart
            - app_theme.dart
        - /translations
            - /langs                   
                - us-en.dart    
        - /utils        
            - validator.dart                          
            - helpers.dart          
- main.dart  
# inspired by william Silva and Kauê Murakami



