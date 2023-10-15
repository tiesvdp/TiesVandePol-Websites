let intro = document.querySelector('.transition');
let logo = document.querySelector('.transition-header');
let logoSpan = document.querySelectorAll('.logoTransition');

window.addEventListener('DOMContentLoaded', ()=>{

    setTimeout(()=>{

        logoSpan.forEach((span, idx)=>{
            setTimeout(()=>{
                    span.classList.add('active');
            }, (idx + 1) * 100)
        });

        setTimeout(()=>{
            logoSpan.forEach((span, idx)=>{

                setTimeout(()=>{
                    span.classList.remove('active');
                    span.classList.add('fade');
                }, (idx + 1) * 10)
            })
        },700)

        setTimeout(()=>{
            intro.style.top = '-100vh';
        }, 700)
    })
})
