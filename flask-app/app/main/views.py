from flask import render_template, request, session, redirect, url_for
from app import app
from . import example_utils
import vapor

@app.route('/')
def home():
    return render_template('home.html')