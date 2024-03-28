from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
import os

main = Flask(__name__)
main.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL')
database = SQLAlchemy(main)

class Person(database.Model):
    __tablename__ = 'Person'
    id = database.Column(database.Integer, primary_key=True)
    full_name = database.Column(database.String(100), nullable=False)
    group_number = database.Column(database.String(100), nullable=False)


@main.route('/<int:person_id>')
def index(person_id):
    person = Person.query.filter_by(id=person_id).first()
    print(person.full_name)
    print(person.group_number)
    return render_template('index.html', person_full_name=person.full_name, person_group_number = person.group_number)

if __name__ == '__main__':
    main.run(host='0.0.0.0', port=5734)