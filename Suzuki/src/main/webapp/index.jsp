<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Suzuki</title>
  <link rel="icon" href="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      padding-top: 80px;
    }

    header {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }

    .hero-carousel {
      height: 90vh;
      overflow: hidden;
    }

    .hero-carousel .carousel-item {
      height: 90vh;
      background-size: cover;
      background-position: center;
      position: relative;
      color: white;
    }

    .hero-carousel .carousel-item::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.5);
    }

    .carousel-caption {
      position: absolute;
      bottom: 25%;
      z-index: 2;
    }

    .carousel-caption h1,
    .carousel-caption p {
      text-shadow: 2px 2px 6px #000;
    }



    /* Gradient and card styles for sections */
    .info-card {
      background: linear-gradient(135deg, #ffffff, #f0f8ff);
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      padding: 25px;
    }

    .info-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .bg-gradient {
      background: linear-gradient(135deg, #e0f7fa, #ffffff);
    }

    .card:hover {
      transform: scale(1.03);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      transition: all 0.3s ease;
    }
  </style>
</head>

<body>

  <!-- HEADER -->
  <header class="bg-dark text-white">
    <div class="d-flex justify-content-between align-items-center px-3 py-2">
      <img src="https://wallpapers.com/images/hd/suzuki-logo3-d-rendering-wr9u1i83mycuikpy-2.jpg" alt="Suzuki Logo" width="50">
      <div>
        <a class="btn btn-info btn-sm" href="#about">About Us</a>
        <a class="btn btn-info btn-sm" href="#contact">Contact Us</a>
        <a class="btn btn-info btn-sm" href="#models">Models</a>
        <a class="btn btn-info btn-sm" href="admin">Admin</a>
        <a class="btn btn-info btn-sm" href="login">Log in</a>
      </div>
    </div>
    <hr color="black">
  </header>

  <!-- AUTO SLIDING CAROUSEL -->
  <div id="heroCarousel" class="carousel slide hero-carousel" data-ride="carousel" data-interval="4000">
    <div class="carousel-inner">
      <div class="carousel-item active" style="background-image: url('https://i.pinimg.com/736x/99/8b/ea/998beaf09f1bb959eb185189f11c71a4.jpg');">
        <div class="carousel-caption text-center">
          <h1 class="display-4">Welcome to Suzuki Bikes</h1>
          <p class="lead">Explore speed, power, and elegance</p>
        </div>
      </div>
      <div class="carousel-item" style="background-image: url('https://iamabiker.com/wp-content/uploads/2015/07/Suzuki-Gixxer-SF-HD-wallpapers-2.jpg');">
        <div class="carousel-caption text-center">
          <h1 class="display-4">Ride the Future</h1>
          <p class="lead">Advanced engineering. Ultimate thrill.</p>
        </div>
      </div>
      <div class="carousel-item" style="background-image: url('https://c4.wallpaperflare.com/wallpaper/566/513/68/bike-custom-hayabusa-motorbike-wallpaper-preview.jpg');">
        <div class="carousel-caption text-center">
          <h1 class="display-4">Born to Perform</h1>
          <p class="lead">Crafted for those who crave speed.</p>
        </div>
      </div>
    </div>
  </div>

  <!-- ABOUT US -->
  <section id="about" class="bg-gradient py-5">
    <div class="container">
      <h2 class="text-center mb-4">About Us</h2>
      <div class="info-card mx-auto" style="max-width: 800px;">
        <p class="text-center">
          Suzuki is a globally recognized brand known for delivering performance, innovation, and cutting-edge technology in motorbikes. From superbikes to street bikes, Suzuki offers power and precision for every rider.
        </p>
      </div>
    </div>
  </section>

  <section id="models" class="py-5">
    <div class="container">
      <h2 class="text-center mb-5">Top Suzuki Models</h2>
      <div class="row">
        <div class="col-md-4 mb-4 d-flex">
          <div class="card h-100 w-100">
            <img class="card-img-top img-fluid" src="https://c4.wallpaperflare.com/wallpaper/932/862/575/suzuki-hayabusa-gsx1300r-1280x960-motorcycles-suzuki-hd-art-wallpaper-preview.jpg" alt="Hayabusa" style="height: 200px; object-fit: cover;">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Suzuki Hayabusa</h5>
              <p class="card-text">A record-breaking machine known for its aerodynamic design and raw speed.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4 d-flex">
          <div class="card h-100 w-100">
            <img class="card-img-top img-fluid" src="https://sahusuzuki.in/wp-content/uploads/2024/08/bule-white-suzuki-gixxer-sf-250-66ae197a86163.webp" alt="Gixxer 155" style="height: 200px; object-fit: cover;">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Suzuki Gixxer 155</h5>
              <p class="card-text">A streetfighter designed for city riders, combining style and fuel efficiency.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-4 d-flex">
          <div class="card h-100 w-100">
            <img class="card-img-top img-fluid" src="https://i.pinimg.com/originals/b2/ae/c9/b2aec9e41259275850aa3f9ccc343ba4.jpg" alt="Intruder 150" style="height: 200px; object-fit: cover;">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">Suzuki Intruder 150</h5>
              <p class="card-text">A modern cruiser built for long-distance comfort with an aggressive look.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>


  <!-- CONTACT US -->
  <section id="contact" class="bg-gradient py-5">
    <div class="container">
      <h2 class="text-center mb-4">Contact Us</h2>
      <div class="info-card mx-auto text-center" style="max-width: 800px;">
        <p>
          Email: <a href="mailto:support@suzukibikes.com">support@suzukibikes.com</a><br>
          Phone: +1-800-555-1234<br>
          Address: Suzuki Motors HQ, Tokyo, Japan
        </p>
      </div>
    </div>
  </section>

  <footer class="bg-dark py-3 mt-auto">
    <div class="container position-relative text-white">

      <div class="text-center">
        <span>Copyright &copy; 2025, All Rights Reserved</span>

      </div>


      <div class="position-absolute" style="right: 0; top: 50%; transform: translateY(-50%); padding-right: 1rem;">
        <span id="datetime"></span>
      </div>
    </div>
  </footer>


  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Live Time
    function updateDateTime() {
      document.getElementById('datetime').textContent =
        new Date().toLocaleString();
    }
    updateDateTime();
    setInterval(updateDateTime, 1000);
  </script>
</body>

</html>
