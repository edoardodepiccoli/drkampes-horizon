# Pagina: Contatti

**Titolo pagina Shopify:** `Contatti`
**Template:** usa `page.contact` per avere il form nativo di Shopify incluso automaticamente in fondo.
Se usi il template default (`page`), il form non apparirà.

Copia il codice HTML qui sotto e incollalo nel campo contenuto della pagina Shopify, dopo aver cliccato su **"Show HTML"** nell'editor.

---

```html
<style>
  .dkc { --accent: #fb6e04; --muted: #555; --light: #f5f5f5; --border: #e0e0e0; }
  .dkc a { color: var(--accent); }
  .dkc .intro { border-left: 3px solid var(--accent); padding-left: 1rem; color: var(--muted); margin-bottom: 2rem; line-height: 1.7; }
  .dkc .cta-row { display: flex; flex-wrap: wrap; gap: 0.6rem; margin: 1.5rem 0 2.5rem; }
  .dkc .btn { display: inline-block; padding: 0.65rem 1.3rem; font-size: 0.82rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; border: 1px solid; text-decoration: none; }
  .dkc .btn-primary { background: var(--accent); color: #fff; border-color: var(--accent); }
  .dkc .btn-outline { background: transparent; color: #111; border-color: #111; }
  .dkc .btn-wa { background: #25D366; color: #fff; border-color: #25D366; }
  .dkc .stats { display: grid; grid-template-columns: 1fr 1fr; gap: 1px; background: var(--border); border: 1px solid var(--border); margin: 2rem 0; }
  .dkc .stat { background: #111; padding: 1.25rem 1.5rem; }
  .dkc .stat strong { display: block; color: var(--accent); font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 0.4rem; }
  .dkc .stat a, .dkc .stat span { color: #fff; font-size: 0.95rem; font-weight: 600; line-height: 1.5; display: block; text-decoration: none; }
  .dkc .contacts { display: flex; flex-direction: column; gap: 1px; background: var(--border); border: 1px solid var(--border); margin: 1.25rem 0; }
  .dkc .contact-item { background: #fff; padding: 1rem 1.25rem; display: flex; flex-direction: column; gap: 0.15rem; }
  .dkc .contact-item strong { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--accent); }
  .dkc .contact-item a, .dkc .contact-item span { font-size: 1rem; font-weight: 700; color: #111; text-decoration: none; }
  .dkc .hours { display: flex; flex-direction: column; gap: 1px; background: var(--border); border: 1px solid var(--border); margin: 1.25rem 0; }
  .dkc .hours-row { background: #fff; padding: 0.85rem 1.25rem; display: flex; justify-content: space-between; gap: 1rem; font-size: 0.9rem; }
  .dkc .hours-row span { color: var(--muted); }
  .dkc .box { background: var(--light); border: 1px solid var(--border); padding: 1.5rem; margin: 0.75rem 0; }
  .dkc .box h3 { margin: 0 0 0.75rem; font-size: 1rem; }
  .dkc ul { padding-left: 1.2rem; color: var(--muted); margin: 0.5rem 0; }
  .dkc li { margin: 0.45rem 0; line-height: 1.6; font-size: 0.95rem; }
  .dkc .faq { display: flex; flex-direction: column; gap: 1px; background: var(--border); border: 1px solid var(--border); margin: 1.25rem 0; }
  .dkc .faq details { background: #fff; }
  .dkc .faq summary { padding: 1rem 1.25rem; cursor: pointer; font-weight: 700; font-size: 0.9rem; list-style: none; display: flex; justify-content: space-between; align-items: center; }
  .dkc .faq summary::-webkit-details-marker { display: none; }
  .dkc .faq summary::after { content: "+"; color: var(--accent); font-size: 1.3rem; line-height: 1; }
  .dkc .faq details[open] summary::after { content: "−"; }
  .dkc .faq p { padding: 0 1.25rem 1rem; color: var(--muted); font-size: 0.88rem; line-height: 1.7; margin: 0; }
  .dkc .note { background: var(--light); border-left: 3px solid var(--accent); padding: 0.9rem 1.1rem; color: var(--muted); font-size: 0.88rem; margin: 2rem 0; }
  @media (max-width: 600px) {
    .dkc .cta-row { flex-direction: column; }
    .dkc .btn { text-align: center; }
    .dkc .hours-row { flex-direction: column; gap: 0.1rem; }
  }
</style>

<div class="dkc">

  <p class="intro">Hai bisogno di informazioni su ordini, personalizzazioni, garanzia o assistenza? Scrivici tramite il form qui sotto oppure usa uno dei nostri contatti diretti. <strong>Ti rispondiamo nel più breve tempo possibile.</strong></p>

  <div class="cta-row">
    <a class="btn btn-primary" href="mailto:info@drkampes.com">Scrivi una email</a>
    <a class="btn btn-outline" href="tel:+393516515219">Chiama ora</a>
    <a class="btn btn-wa" href="https://wa.me/393516515219?text=Ciao%20Dr%20Kampes%2C%20vorrei%20ricevere%20informazioni." target="_blank" rel="noopener noreferrer">WhatsApp</a>
    <a class="btn btn-outline" href="/pages/garanzia-3-anni-dr-kampes">Vai alla Garanzia</a>
  </div>

  <div class="stats">
    <div class="stat"><strong>Email</strong><a href="mailto:info@drkampes.com">info@drkampes.com</a></div>
    <div class="stat"><strong>Telefono</strong><a href="tel:+393516515219">+39 351 651 5219</a></div>
    <div class="stat"><strong>WhatsApp</strong><a href="https://wa.me/393516515219?text=Ciao%20Dr%20Kampes%2C%20vorrei%20ricevere%20informazioni." target="_blank" rel="noopener noreferrer">Apri la chat</a></div>
    <div class="stat"><strong>Sede</strong><span>Via Noalese 84/E, Treviso</span></div>
  </div>

  <h2>Contatti diretti</h2>

  <div class="contacts">
    <div class="contact-item"><strong>Email</strong><a href="mailto:info@drkampes.com">info@drkampes.com</a></div>
    <div class="contact-item"><strong>Telefono</strong><a href="tel:+393516515219">+39 351 651 5219</a></div>
    <div class="contact-item"><strong>WhatsApp</strong><a href="https://wa.me/393516515219?text=Ciao%20Dr%20Kampes%2C%20vorrei%20ricevere%20informazioni." target="_blank" rel="noopener noreferrer">Apri la chat WhatsApp</a></div>
    <div class="contact-item"><strong>Indirizzo</strong><span>Via Noalese 84/E, 31100 Treviso (TV), Italia</span></div>
  </div>

  <p style="font-size:0.88rem; color:#555;">Per richieste relative a garanzia o assistenza tecnica, indica sempre numero ordine, fattura o altri riferimenti utili.</p>

  <h2>Orari</h2>

  <div class="hours">
    <div class="hours-row"><strong>Lunedì – Venerdì</strong><span>09:00 – 13:00 / 14:30 – 18:30</span></div>
    <div class="hours-row"><strong>Sabato</strong><span>Su appuntamento</span></div>
    <div class="hours-row"><strong>Domenica</strong><span>Chiuso</span></div>
  </div>

  <h2>Per cosa puoi contattarci</h2>

  <div class="box">
    <h3>Supporto e assistenza</h3>
    <ul>
      <li>Informazioni su ordini e spedizioni</li>
      <li>Richieste su garanzia e post-vendita</li>
      <li>Segnalazioni su prodotto e supporto tecnico</li>
      <li>Dubbi su taglie, utilizzo e caratteristiche</li>
    </ul>
  </div>

  <div class="box">
    <h3>Richieste commerciali</h3>
    <ul>
      <li>Forniture per aziende e professionisti</li>
      <li>Personalizzazioni e richieste speciali</li>
      <li>Collaborazioni commerciali</li>
      <li>Informazioni generali sul brand Dr Kampes</li>
    </ul>
  </div>

  <h2>Domande frequenti</h2>

  <div class="faq">
    <details>
      <summary>Quanto tempo impiegate a rispondere?</summary>
      <p>Cerchiamo di rispondere nel più breve tempo possibile. I tempi variano in base al tipo di richiesta e al periodo.</p>
    </details>
    <details>
      <summary>Posso contattarvi anche via WhatsApp?</summary>
      <p>Sì. Usa il pulsante WhatsApp presente in questa pagina per aprire direttamente la chat con Dr Kampes.</p>
    </details>
    <details>
      <summary>Posso chiedere informazioni su ordini aziendali o personalizzati?</summary>
      <p>Sì. Specifica quantità, tipo di personalizzazione e dati aziendali per ricevere una risposta più rapida.</p>
    </details>
    <details>
      <summary>Per assistenza su un prodotto acquistato, cosa devo indicare?</summary>
      <p>Numero ordine o fattura, descrizione del problema, fotografie e, se possibile, lotto del prodotto.</p>
    </details>
  </div>

  <div class="note">Il form di contatto appare qui sotto se la pagina usa il template <strong>page.contact</strong>.</div>

</div>
```
