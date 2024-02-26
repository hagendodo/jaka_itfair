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
                            <form method="POST" action="{{ route('login.do') }}" class="form-horizontal m-t-30">
                                @csrf
                                <div class="form-group">
                                    <label for="email">No Whatsapp</label>
                                    <input type="number" id="email" name="phone" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                                <div class="text-right">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>
                                <div>
                                    Belum punya akun? <a href="{{ route('register.index') }}">Register disini</a>
                                </div>
                            </form>
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
