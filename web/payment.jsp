<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="model.Book" %>

<%
    String bookIdParam = request.getParameter("bookId");
    if (bookIdParam == null || bookIdParam.trim().isEmpty()) {
        out.println("<h2>Book not specified.</h2>");
        return;
    }

    int bookId;
    try {
        bookId = Integer.parseInt(bookIdParam);
    } catch (NumberFormatException e) {
        out.println("<h2>Invalid book ID.</h2>");
        return;
    }

    Book book = BookDAO.getBookById(bookId);
    if (book == null) {
        out.println("<h2>Book not found.</h2>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Checkout • <%= book.getTitle()%></title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root{
                --bg:#f6f7fb;
                --card:#ffffff;
                --text:#0f172a;
                --muted:#576176;
                --border:#e5e7eb;
                --primary:#2563eb;
                --primary-hover:#1e40af;
                --ring:rgba(37,99,235,.2);
            }
            *{
                box-sizing:border-box
            }
            body{
                margin:0;
                font-family:Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial, Helvetica, sans-serif;
                background:var(--bg);
                color:var(--text);
                min-height:100vh;
                display:flex;
                align-items:center;
                justify-content:center;
                padding:24px;
            }
            .wrap{
                width:100%;
                max-width:880px;
                display:grid;
                grid-template-columns:1.1fr .9fr;
                gap:20px
            }
            @media (max-width:900px){
                .wrap{
                    grid-template-columns:1fr
                }
            }
            .card{
                background:var(--card);
                border:1px solid var(--border);
                border-radius:16px;
                box-shadow:0 10px 30px rgba(15,23,42,.06);
            }
            .p24{
                padding:24px
            }
            h1{
                margin:0 0 6px;
                font-size:1.3rem
            }
            .sub{
                color:var(--muted);
                font-size:.95rem;
                margin:0 0 12px
            }
            .field{
                margin-bottom:14px
            }
            .label{
                display:block;
                font-weight:600;
                margin:0 0 6px;
                font-size:.92rem
            }
            .grid2{
                display:grid;
                grid-template-columns:1fr 1fr;
                gap:10px
            }
            input{
                width:100%;
                padding:12px 14px;
                border:1.5px solid var(--border);
                border-radius:10px;
                font-size:1rem;
                outline:none;
                transition:.2s border-color, .2s box-shadow
            }
            input:focus{
                border-color:var(--primary);
                box-shadow:0 0 0 6px var(--ring)
            }
            .hint{
                font-size:.8rem;
                color:var(--muted);
                margin-top:6px
            }
            .qty{
                display:flex;
                align-items:center;
                gap:8px;
                border:1.5px solid var(--border);
                border-radius:10px;
                padding:6px 6px 6px 8px;
                width:max-content;
                background:#fafafa;
            }
            .qty input{
                width:64px;
                border:0;
                background:transparent;
                text-align:center;
                padding:8px 4px
            }
            .qty button{
                border:0;
                background:#fff;
                border:1px solid var(--border);
                width:32px;
                height:32px;
                border-radius:8px;
                cursor:pointer;
                font-size:18px;
                line-height:1;
            }
            .qty button:hover{
                background:#f3f4f6
            }
            .btn{
                width:100%;
                padding:14px 16px;
                border:0;
                border-radius:12px;
                background:var(--primary);
                color:#fff;
                font-weight:700;
                letter-spacing:.2px;
                font-size:1rem;
                cursor:pointer;
                box-shadow:0 10px 24px rgba(37,99,235,.25);
                transition:.2s filter, .06s transform;
            }
            .btn:hover{
                background:var(--primary-hover)
            }
            .btn:active{
                transform:translateY(1px)
            }
            .line{
                height:1px;
                background:var(--border);
                margin:12px 0
            }
            .sum{
                display:grid;
                gap:10px;
                font-size:.98rem
            }
            .sum-row{
                display:flex;
                justify-content:space-between;
                color:#334155
            }
            .sum-row.total{
                font-weight:800;
                color:#0f172a
            }
            .book{
                display:flex;
                gap:12px;
                align-items:flex-start;
                padding:12px;
                border:1px dashed var(--border);
                border-radius:12px;
                background:#fafafa;
                margin-top:6px;
            }
            .cover{
                width:56px;
                height:76px;
                border-radius:8px;
                background:linear-gradient(135deg,#c7d2fe,#93c5fd)
            }
            .tiny{
                font-size:.86rem;
                color:#475569
            }
        </style>
    </head>
    <body>
        <div class="wrap">
            <!-- Payment form -->
            <div class="card p24">
                <h1>Secure Payment</h1>
                <p class="sub">Complete your purchase below. We’ll email you a receipt.</p>

                <form action="ProcessPaymentServlet" method="post" id="payForm" novalidate>
                    <input type="hidden" name="bookId" value="<%= book.getBookId()%>" />

                    <div class="field">
                        <span class="label">Cardholder Name</span>
                        <input type="text" name="cardName" placeholder="e.g., R. Perera" required />
                    </div>

                    <div class="field">
                        <span class="label">Card Number</span>
                        <!-- keep name=cardNumber for your servlet; allow grouping visually -->
                        <input type="text" id="cardNumber" name="cardNumber" inputmode="numeric"
                               autocomplete="cc-number" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" required />
                        <div id="cardHint" class="hint">Enter 16 digits.</div>
                    </div>

                    <div class="grid2">
                        <div class="field">
                            <span class="label">Expiry (MM/YY)</span>
                            <input type="text" id="expiry" name="expiry" inputmode="numeric"
                                   autocomplete="cc-exp" placeholder="MM/YY" maxlength="5" required />
                        </div>
                        <div class="field">
                            <span class="label">CVV</span>
                            <input type="password" id="cvv" name="cvv" inputmode="numeric"
                                   autocomplete="cc-csc" placeholder="123" maxlength="4" required />
                        </div>
                    </div>

                    <div class="field">
                        <span class="label">Email for receipt (optional)</span>
                        <input type="email" name="email" placeholder="you@example.com" />
                    </div>

                    <div class="line"></div>

                    <button class="btn" id="payButton" type="submit">
                        Pay LKR <%= String.format("%.2f", book.getPricePerUnit())%>
                    </button>
                </form>
            </div>

            <!-- Order summary -->
            <div class="card p24">
                <h1>Order Summary</h1>
                <div class="book">
                    <div class="cover" aria-hidden="true"></div>
                    <div>
                        <div style="font-weight:700"><%= book.getTitle()%></div>
                        <div class="tiny">by <%= book.getAuthor()%></div>
                        <div class="tiny" style="margin-top:6px">Price: LKR <%= String.format("%.2f", book.getPricePerUnit())%> / unit</div>
                    </div>
                </div>

                <div style="margin:14px 0 8px" class="tiny">Quantity</div>
                <div class="qty">
                    <button type="button" id="decQty" aria-label="Decrease">−</button>
                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="100" />
                    <button type="button" id="incQty" aria-label="Increase">+</button>
                </div>

                <div class="line"></div>

                <div class="sum">
                    <div class="sum-row"><span>Subtotal</span><span id="subtotal">LKR <%= String.format("%.2f", book.getPricePerUnit())%></span></div>
                    <div class="sum-row"><span>Delivery</span><span>FREE</span></div>
                    <div class="sum-row total"><span>Total</span><span id="total">LKR <%= String.format("%.2f", book.getPricePerUnit())%></span></div>
                </div>
            </div>
        </div>

        <script>
            (function () {
                const price = <%= book.getPricePerUnit()%>;
                const qty = document.getElementById('quantity');
                const dec = document.getElementById('decQty');
                const inc = document.getElementById('incQty');
                const subtotal = document.getElementById('subtotal');
                const total = document.getElementById('total');
                const payBtn = document.getElementById('payButton');

                function fmt(v) {
                    return 'LKR ' + (Math.round(v * 100) / 100).toFixed(2);
                }
                function sync() {
                    const q = Math.max(1, Math.min(100, parseInt(qty.value || '1', 10)));
                    qty.value = q;
                    const sub = price * q;
                    subtotal.textContent = fmt(sub);
                    total.textContent = fmt(sub);
                    payBtn.textContent = 'Pay ' + fmt(sub);
                }
                dec.addEventListener('click', () => {
                    qty.stepDown();
                    sync();
                });
                inc.addEventListener('click', () => {
                    qty.stepUp();
                    sync();
                });
                qty.addEventListener('input', sync);
                sync();

                // Helpers
                const card = document.getElementById('cardNumber');
                const expiry = document.getElementById('expiry');
                const cvv = document.getElementById('cvv');
                const cardHint = document.getElementById('cardHint');

                const digits = s => s.replace(/\D+/g, '');

                // visual grouping as user types
                card.addEventListener('input', () => {
                    let d = digits(card.value).slice(0, 16);
                    card.value = (d.match(/.{1,4}/g) || []).join(' ');
                    cardHint.textContent = d.length === 16 ? 'Looks good.' : 'Enter 16 digits.';
                });

                expiry.addEventListener('input', () => {
                    let d = digits(expiry.value).slice(0, 4);
                    if (d.length >= 3)
                        d = d.slice(0, 2) + '/' + d.slice(2);
                    expiry.value = d;
                });

                cvv.addEventListener('input', () => {
                    cvv.value = digits(cvv.value).slice(0, 4);
                });

                // IMPORTANT: normalize before submit so servlet sees plain digits
                document.getElementById('payForm').addEventListener('submit', (e) => {
                    // strip spaces so it passes matches("\\d{16}")
                    card.value = digits(card.value);          // <-- key fix
                    // Optional: simple front-end checks (server still validates)
                    const d = card.value;
                    const ex = expiry.value;
                    const c = digits(cvv.value);
                    let ok = true, msg = [];
                    if (d.length !== 16) {
                        ok = false;
                        msg.push('Card number must be 16 digits');
                    }
                    if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(ex)) {
                        ok = false;
                        msg.push('Expiry must be MM/YY');
                    }
                    if (c.length < 3) {
                        ok = false;
                        msg.push('CVV must be 3–4 digits');
                    }
                    if (!ok) {
                        e.preventDefault();
                        alert('Please fix:\n• ' + msg.join('\n• '));
                    }
                });
            })();
        </script>
    </body>
</html>
