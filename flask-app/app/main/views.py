from flask import render_template, request, session, redirect, url_for
from app import app
from . import example_utils
from vapor import session, renderer, dataset, camera

@app.route('/')
def home():
    #ses.Render("/app/flask-app/vapor.png")
    return render_template('home.html')

@app.route('/vapor')
def vapor():
    ses = session.Session()
    data = example_utils.OpenExampleDataset(ses)

    ren = data.NewRenderer(renderer.VolumeIsoRenderer)
    ren.SetIsoValues([-0.10, 0.2])

    # Show 3D orientation arrows.
    ses.GetSceneAnnotations().SetAxisArrowEnabled(True)
    cam = ses.GetCamera()
    cam.ViewAll()
    return ses.Show()

@app.route('/navbar')
def navbar():
    return render_template('navbar.html')