document.addEventListener('DOMContentLoaded', function() {
  // Gestion du clic sur la box Débutant
  const debutantBox = document.querySelector('.level-box.active');
  if (debutantBox) {
    debutantBox.addEventListener('click', function() {
      window.location.href = '/gameregles.html';
    });
  }
  // Les autres box sont verrouillées
  document.querySelectorAll('.level-box.locked').forEach(box => {
    box.addEventListener('click', function(e) {
      e.preventDefault();
    });
  });
});
