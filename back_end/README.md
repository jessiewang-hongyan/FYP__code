This is the back-end code implementation of my Final Year Project.


# Before running the code #:
A predictive model is required in ./flaskr/trained_model/edu_0330.
Due to the size constraint of code submission of FYPMS, we cannot contain it in this submission.
You may access it here: https://drive.google.com/file/d/1fpF8zJhxXsuoPbQWP6FHdQwNt_O3DjMJ/view?usp=sharing


# How to run the code #:
1. create a virtual environment according to requirements.txt
2. activate the environment
    > venv\Scripts\activate
3. designate the execution entry and environment
    > $env:FLASK_APP='__init__.py'
    > $env:FLASK_ENV='development'
4. go to the directory that contains the entry file
    > cd flaskr
5. run the program
    > flask run


# APIs #:
After that, you may access the APIs in localhost. Two APIs are provided.

/hello: only accept GET method.
    return a greeting message in raw string.

/request: only accept POST method.
    accept the user input in JSON and return the prediction of intent and classification.
    JSON format:
    {
        'input': <The String of User Utterance>
    }
