<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create New Bill</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(to right, #e1f5fe, #ede7f6);
            font-family: 'Segoe UI', sans-serif;
        }

        h2 {
            font-weight: 600;
            color: #5e35b1;
        }

        .card {
            background: #ffffffee;
            border-radius: 20px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            padding: 30px;
        }

        .table thead {
            background-color: #d1c4e9;
            color: #4a148c;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f3e5f5;
        }

        .btn-primary {
            background-color: #7e57c2;
            border-color: #7e57c2;
        }

        .btn-secondary {
            background-color: #90caf9;
            border-color: #64b5f6;
            color: #000;
        }

        .btn-danger {
            background-color: #ef5350;
            border-color: #e53935;
        }

        .form-select, .form-control {
            border-radius: 10px;
        }

        .total-summary {
            font-size: 1.2rem;
            color: #311b92;
        }

        .btn-secondary:hover {
            background-color: #64b5f6;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <div class="card">
        <h2 class="mb-4">🧾 Create New Bill</h2>

        <form action="create-bill" method="post">
            <!-- Select Customer -->
            <div class="mb-4">
                <label for="customerId" class="form-label">Select Customer</label>
                <select name="customerId" id="customerId" class="form-select" required>
                    <option value="">-- Choose --</option>
                    <c:forEach var="customer" items="${customers}">
                        <option value="${customer.id}">${customer.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Items Table -->
            <div class="table-responsive mb-3">
                <table class="table table-bordered" id="itemsTable">
                    <thead>
                    <tr>
                        <th>Item</th>
                        <th>Stock</th>
                        <th>Price (Rs.)</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody id="itemRows">
                    <!-- Dynamic rows added by JS -->
                    </tbody>
                </table>
            </div>

            <button type="button" class="btn btn-secondary mb-4" onclick="addItemRow()">+ Add Item</button>

            <!-- Total -->
            <div class="mb-4 text-end total-summary">
                <strong>Total Amount: Rs. <span id="totalAmount">0.00</span></strong>
                <input type="hidden" name="totalAmount" id="totalAmountInput" />
            </div>

            <!-- Submit + Cancel -->
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">💾 Submit Bill</button>
                <a href="${pageContext.request.contextPath}/Staff/manage-bills" class="btn btn-secondary">⬅ Cancel</a>
            </div>
        </form>
    </div>
</div>

<!-- Hidden Items Template -->
<select id="items-options" style="display:none;">
    <c:forEach var="item" items="${items}">
        <option value="${item.id}" data-price="${item.price}" data-stock="${item.stockQuantity}">${item.name}</option>
    </c:forEach>
</select>

<!-- JavaScript -->
<script>
    function addItemRow() {
        const tbody = document.getElementById('itemRows');
        const row = document.createElement('tr');

        const selectClone = document.getElementById('items-options').cloneNode(true);
        selectClone.style.display = '';
        selectClone.id = '';
        selectClone.name = "itemIds";
        selectClone.classList.add('form-select', 'item-select');
        selectClone.required = true;

        row.innerHTML = `
            <td></td>
            <td class="stock">-</td>
            <td class="price">0.00</td>
            <td><input type="number" name="quantities" class="form-control qty-input" min="1" value="1" required /></td>
            <td class="total">0.00</td>
            <td><button type="button" class="btn btn-danger btn-sm">🗑</button></td>
        `;

        row.cells[0].appendChild(selectClone);
        tbody.appendChild(row);

        setupRowEvents(row);

        row.querySelector('button').addEventListener('click', () => {
            row.remove();
            updateTotal();
        });
    }

    function setupRowEvents(row) {
        const select = row.querySelector('.item-select');
        const qtyInput = row.querySelector('.qty-input');

        select.addEventListener('change', () => {
            const option = select.selectedOptions[0];
            const price = parseFloat(option.dataset.price || 0);
            const stock = option.dataset.stock || '-';

            row.querySelector('.price').textContent = price.toFixed(2);
            row.querySelector('.stock').textContent = stock;
            updateRowTotal(row);
        });

        qtyInput.addEventListener('input', () => updateRowTotal(row));
    }

    function updateRowTotal(row) {
        const price = parseFloat(row.querySelector('.price').textContent || 0);
        const qty = parseInt(row.querySelector('.qty-input').value || 0);
        const total = price * qty;
        row.querySelector('.total').textContent = total.toFixed(2);
        updateTotal();
    }

    function updateTotal() {
        const totals = document.querySelectorAll('.total');
        let grandTotal = 0;
        totals.forEach(t => {
            const val = parseFloat(t.textContent);
            if (!isNaN(val)) grandTotal += val;
        });
        document.getElementById('totalAmount').textContent = grandTotal.toFixed(2);
        document.getElementById('totalAmountInput').value = grandTotal.toFixed(2);
    }

    window.onload = () => {
        addItemRow();
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
