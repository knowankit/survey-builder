# Survey Builder API

Welcome to the Survey Builder backend repository! This project is dedicated to the backend development of the Survey Builder application, which serves as the foundation for the Survey Builder UI frontend. Built using Ruby on Rails and leveraging PostgreSQL as the database, this backend system manages crucial resources such as users, answers, surveys, questions, question options, and responses.

This app is also dockerise so after the cloning the repo you can run `docker-compose up` to start it and access the api at `localhost:3001`. Test it by visiting  `localhost:3001/heartbeat`.

## Features

- **User Management**: Handle user authentication, registration, and profiles.
- **Survey Management**: Create, edit, publish, and unpublish surveys.
- **Question Types**: Support multiple question types like multiple-choice, open-text, ratings, and more.
- **Response Collection**: Collect and store responses from survey participants.
- **Data Integrity**: Utilize PostgreSQL to ensure reliable data storage and retrieval.

## Getting Started

To set up and run the Survey Builder backend on your local machine, follow these steps:

1. **Clone the Repository**: Clone this repository to your local machine using Git.

   ```bash
   git clone https://github.com/knowankit/survey-builder.git
   cd survey-builder
   ```

2. **Install Dependencies**: Install the required Ruby gems using Bundler.

   ```bash
   bundle install
   ```

3. **Database Setup**: Configure your PostgreSQL database credentials in `config/database.yml`. Then, create and migrate the database.

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the Server**: Launch the Rails server.

   ```bash
   rails server
   ```

5. **API Endpoints**: Explore and interact with the API endpoints to manage surveys, questions, responses, and more. Refer to the API documentation or routes file for more details.

Absolutely! Here's how you can structure the API endpoints in a tabular format:

## API Endpoints

Below is a list of key API endpoints available in the Survey Builder backend:

| Endpoint                        | Method | Description                                       |
|---------------------------------|--------|---------------------------------------------------|
| **Users**                        |        |                                                   |
| /api/v1/users/register              | POST   | Register a new user account.                     |
| /api/v1/users/login                 | POST   | Authenticate a user and generate a token.        |
| /api/v1/users/profile               | GET    | Retrieve user profile information.               |
| **Surveys**                      |        |                                                   |
| /api/v1/surveys                     | GET    | Get a list of all surveys.                       |
| /api/v1/surveys/:id                 | GET    | Get details of a specific survey.               |
| /api/v1/surveys                     | POST   | Create a new survey.                             |
| /api/v1/surveys/:id                 | PUT    | Update survey details.                           |
| /api/v1/surveys/:id                 | DELETE | Delete a survey.                                 |
| **Questions**                    |        |                                                   |
| /api/v1/questions                   | GET    | Get a list of all questions for a survey.        |
| /api/v1/questions/:id               | GET    | Get details of a specific question.             |
| /api/v1/questions                   | POST   | Create a new question for a survey.             |
| /api/v1/questions/:id               | PUT    | Update question details.                        |
| /api/v1/questions/:id               | DELETE | Delete a question.                               |
| **Question Options**             |        |                                                   |
| /api/v1/question_options            | GET    | Get options for a specific question.            |
| /api/v1/question_options            | POST   | Add new options to a question.                  |
| /api/v1/question_options/:id        | PUT    | Update option details.                          |
| /api/v1/question_options/:id        | DELETE | Delete an option.                                |
| **Responses**                    |        |                                                   |
| /api/v1/responses/:id                   | GET    | Get responses for a specific survey.            |
| /api/v1/responses                   | POST   | Submit a response for a survey.                 |
| /api/v1/responses                   | GET   | Get all responses           |
| /heartbeat                   | GET   | Get API running status           |

## Database Structure

The Survey Builder backend uses PostgreSQL for data storage. Here's an overview of the database structure and key resources:

- **Users**: Store user information and authentication credentials.
- **Surveys**: Manage survey details such as title, description, and publication status.
- **Questions**: Define questions with various types and options.
- **Question Options**: Store options for multiple-choice and other related questions.
- **Responses**: Capture responses from participants for analysis.
- **Answers**: Store answers for each survey questions

## Contributing

We welcome contributions from the open-source community! If you're interested in improving the Survey Builder backend, feel free to fork this repository, make your changes, and submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE), which grants you the freedom to use, modify, and distribute the software according to the terms specified.

Thank you for your interest in the Survey Builder backend. By collaborating on this project, we aim to empower the development of a robust and feature-rich survey management system. If you have any questions or need assistance, please don't hesitate to reach out to us.
