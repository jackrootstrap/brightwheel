# README

## IMPLENTATION

3 Endpoints were created to solve the requirements.

Due to the database restriction, Device readings data will be saved using rails cache. 

After saving readings for a device, the upcomings payloads with for this one are considered as duplicated and will be ignored.

In order to improve the solution, we could create a database, add Devise and Reading models, create an index for the timestamp column and will move some validations to models.


## INSTALATION

* Clone the repository (https://github.com/jackrootstrap/brightwheel)

* Go to project folder and run `bundle install`

* Run `rails dev:cache` in order to use rails cache

* run `rails s` to start the server

## Endpoints

* Endpoint `POST /api/v1/readings/` will record readings

   device id and readings params should be sent in the request.

    JSON example:

    ```yaml
    {
        "id": "36d5658a-6908-479e-887e-a949ec199272",
        "readings": [
            {
                "timestamp": "2021-09-29T16:08:15+01:00",
                "count": 4
            },
            {
                "timestamp": "YUDS-09-29T16:09:15+01:00",
                "count": 15
            }
        ]
     }
    ```

    It will return a success message when params are valid.

    ```yaml
    { "message": "sucess" } 
    ```

    It will ignore the payload if device readings is already recorded.

    ```yaml
    { "error": "Payload ignored" }
    ```

    It params are incompleted or malformed, It returns the described error.

    ```yaml
    { "error": "Invalid readings" }
    ```
       

* Endpoint `GET /api/v1/readings/:id/latest` will retrieve the most recent reading for a given device id. 

    replace :id params with device id information.

    This endpoint will return a JSON like this.
    
    ```yaml
        {
            "latest_reading": {
                "timestamp": "2021-09-29T16:09:15.000+01:00",
                "count": 15
            }
        }
    ```
    
    If device readings are not stored, it will return a not found error message.
    
    ```yaml
    { "error": "device not found" }
    ```

* Endpoint `GET /api/v1/readings/:id/cumulative_count` will retrieve the cumulative count for a given device id.

    replace :id params with device id information.
    
    This endpoint will return a JSON like this.
 
    ```yaml
    { "cumulative_count": 17 }
    ```

    If device readings are not stored, it will return a not found error message.

    ```yaml
    { "error": "device not found" }
    ```

## Testing

* Run `rspec` in order to run all the specs


## Missing

* Adding specs to validate all endpoints

