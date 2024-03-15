import example_utils
from vapor import session, renderer, dataset, camera

ses = session.Session()
data = example_utils.OpenExampleDataset(ses)

ren = data.NewRenderer(renderer.VolumeIsoRenderer)
ren.SetIsoValues([-0.10, 0.2])

# Show 3D orientation arrows.
ses.GetSceneAnnotations().SetAxisArrowEnabled(True)
cam = ses.GetCamera()

#ses.Render("/app/flask-app/vapor.png")
cam.ViewAll()
ses.Show()