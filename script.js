// Theme Toggle
const themeToggle = document.getElementById('themeToggle');
const htmlElement = document.documentElement;
const bodyElement = document.body;

// Check for saved theme preference or system preference
const savedTheme = localStorage.getItem('theme');
const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
const initialTheme = savedTheme || (prefersDark ? 'dark' : 'light');

// Set initial theme
if (initialTheme === 'dark') {
    htmlElement.setAttribute('data-theme', 'dark');
    bodyElement.classList.add('dark-mode');
} else {
    htmlElement.setAttribute('data-theme', 'light');
    bodyElement.classList.remove('dark-mode');
}

// Theme toggle listener
if (themeToggle) {
    themeToggle.addEventListener('click', () => {
        const currentTheme = htmlElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';

        htmlElement.setAttribute('data-theme', newTheme);

        // Update body class for backward compatibility
        if (newTheme === 'dark') {
            bodyElement.classList.add('dark-mode');
        } else {
            bodyElement.classList.remove('dark-mode');
        }

        localStorage.setItem('theme', newTheme);
    });
}

// Mobile Navigation Toggle
const hamburger = document.getElementById('hamburger');
const navMenu = document.getElementById('navMenu');
const overlay = document.querySelector('.overlay');

if (hamburger) {
    hamburger.addEventListener('click', () => {
        navMenu.classList.toggle('active');
        hamburger.classList.toggle('active');
        overlay.classList.toggle('active');
    });
}

if (overlay) {
    overlay.addEventListener('click', () => {
        navMenu.classList.remove('active');
        hamburger.classList.remove('active');
        overlay.classList.remove('active');
    });
}

// Close mobile menu when link is clicked
const navLinks = document.querySelectorAll('.nav-menu a');
navLinks.forEach(link => {
    link.addEventListener('click', () => {
        navMenu.classList.remove('active');
        hamburger.classList.remove('active');
        overlay.classList.remove('active');
    });
});

// Smooth scroll offset for fixed navbar
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (href === '#') return;

        e.preventDefault();
        const element = document.querySelector(href);
        if (element) {
            const navHeight = document.querySelector('.navbar').offsetHeight;
            const elementPosition = element.getBoundingClientRect().top + window.pageYOffset;
            window.scrollTo({
                top: elementPosition - navHeight,
                behavior: 'smooth'
            });
        }
    });
});

// Intersection Observer for fade-in animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe cards and items for animation
document.querySelectorAll('.competency-card, .project-card, .cert-item, .contact-item, .timeline-content, .venture-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
});

// Skills Carousel
const skillsCarousel = document.getElementById('skillsCarousel');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');
const indicatorsContainer = document.getElementById('indicators');

if (skillsCarousel) {
    const slides = document.querySelectorAll('.carousel-slide');
    let currentSlide = 0;
    let autoSlideInterval;

    // Create indicators
    slides.forEach((_, index) => {
        const indicator = document.createElement('div');
        indicator.className = 'indicator';
        if (index === 0) indicator.classList.add('active');
        indicator.addEventListener('click', () => goToSlide(index));
        indicatorsContainer.appendChild(indicator);
    });

    const indicators = document.querySelectorAll('.indicator');

    function updateCarousel() {
        slides.forEach((slide, index) => {
            slide.classList.remove('active');
            indicators[index].classList.remove('active');
        });
        slides[currentSlide].classList.add('active');
        indicators[currentSlide].classList.add('active');
    }

    function nextSlide() {
        currentSlide = (currentSlide + 1) % slides.length;
        updateCarousel();
        resetAutoSlide();
    }

    function prevSlide() {
        currentSlide = (currentSlide - 1 + slides.length) % slides.length;
        updateCarousel();
        resetAutoSlide();
    }

    function goToSlide(index) {
        currentSlide = index;
        updateCarousel();
        resetAutoSlide();
    }

    function autoSlide() {
        nextSlide();
    }

    function resetAutoSlide() {
        clearInterval(autoSlideInterval);
        autoSlideInterval = setInterval(autoSlide, 5000);
    }

    // Event listeners
    if (prevBtn) prevBtn.addEventListener('click', prevSlide);
    if (nextBtn) nextBtn.addEventListener('click', nextSlide);

    // Start auto-slide
    autoSlideInterval = setInterval(autoSlide, 5000);

    // Pause auto-slide on hover
    if (skillsCarousel) {
        skillsCarousel.addEventListener('mouseenter', () => clearInterval(autoSlideInterval));
        skillsCarousel.addEventListener('mouseleave', resetAutoSlide);
    }
}



