<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png">
    <title>Merchant - Jaka</title>
    <!-- Custom CSS -->
    <link href="dist/css/style.min.css" rel="stylesheet">
    <link rel = "stylesheet" href = "http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css"/>
</head>

<body>
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical"
        style="background-color: #f2f4f5; min-height: 100vh;">
        <div class="py-5 m-2">
            <div class="container-fluid">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <div class="card card-body shadow-sm">
                            <div class="text-center">
                                <h4 class="card-title">Login Merchant</h4>
                                <h5 class="card-subtitle"> Jaka</h5>
                            </div>
                            <form method="POST" action="{{ route('register.do') }}" class="form-horizontal m-t-30" id="registerForm">
                                @csrf
                                <div class="form-group">
                                    <label for="email">Nama Merchant</label>
                                    <input type="text" id="name" name="name" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">No Whatsapp</label>
                                    <input type="number" id="phone" name="phone" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">Alamat</label>
                                    <textarea id="address" name="address" class="form-control" required></textarea>
                                </div>
                                <div class="form-group">
                                    <div id = "map" style = "width: 100%; height: 200px"></div>
                                    <input type="text" id="latitude" name="lat" class="form-control" required hidden="hidden">
                                    <input type="text" id="longitude" name="lng" class="form-control" required hidden="hidden">
                                </div>
                                <div class="text-right">
                                    <button type="submit" class="btn btn-primary" id="submitButton">Register</button>
                                </div>
                                <div>
                                    Sudah punya akun? <a href="{{ route('login.index') }}">Login disini</a>
                                </div>
                            </form>

                            <script src = "http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script>
                            <script>
                                // Creating map options
                                let mapOptions = {
                                    center:[-6.930320, 107.718499],
                                    zoom:17
                                }

                                let map = new L.map('map' , mapOptions);

                                let layer = new L.TileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png');
                                map.addLayer(layer);


                                let marker = null;
                                map.on('click', (event)=> {

                                    if(marker !== null){
                                        map.removeLayer(marker);
                                    }

                                    marker = L.marker([event.latlng.lat , event.latlng.lng]).addTo(map);

                                    document.getElementById('latitude').value = event.latlng.lat;
                                    document.getElementById('longitude').value = event.latlng.lng;

                                })
                            </script>

                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <script src="assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="dist/js/custom.min.js"></script>
</body>

</html>
