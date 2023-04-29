# Generative Agents with Django

We are excited to announce the first release of our Generative Agents with Django application! Our application combines a game, a chatbot (ChatGPT), and an interface to create believable and useful human behavior simulacra.

The goal of our application is to provide a unique experience where users can interact with agents that simulate human-like behavior in response to their inputs. To achieve this, we have implemented a memory module for ChatGPT to store and retrieve important information, as well as a retrieval function to pull relevant context from the world to generate responses.

## Key Features

- Combination of a game, ChatGPT, and an interface to create believable human behavior simulacra
- Memory module for ChatGPT to store and retrieve important information
- Retrieval function to pull relevant context from the world
- Admin panel where you can configure all the world data, from storyline, to characters, their relationships, and so on.

## Installation

To install the Generative Agents with Django, follow these steps:

- Clone the repository to your local machine.
```
git clone https://github.com/yourrepository.git
```

- Create a Python virtual environment and activate it.
```
python -m venv env
source env/bin/activate
```
- Install the required packages using pip.
```
pip install -r requirements.txt
```

- Add your OpenAI API key and Django API key to the .env file.

```
OPENAI_API_KEY=your_openai_api_key_here
DJANGO_API_KEY=your_django_api_key_here
```

- Run the migration commands to create the necessary database tables.

```
python manage.py makemigrations
python manage.py migrate
```

- Create a superuser for the application.

```
python manage.py createsuperuser
```

- Go to `http://localhost:8000/admin/` to create the world. You will need to create a storyline and at least two characters.


## Usage

To use the Generative Agents with Django, follow these steps:

- Run the development server using the following command:

```
python manage.py runserver
```

- Open your web browser and go to 
```
http://localhost:8000/chatbot/?char1=NAME_OF_CHAR_1&char2=NAME_OF_CHAR_2
```
where NAME_OF_CHAR_1 and NAME_OF_CHAR_2 are the names of the characters you created in the previous step.

- Interact with the characters to experience their human-like behavior in the context of the story you created.

## Conclusion

Thank you for choosing Generative Agents with Django! 
We believe this application will provide our team with a unique and valuable experience as we continue to explore the potential of generative agents. 
We encourage everyone to give it a try and provide feedback to help us improve it.




