/**
 * Department Management System - Main JavaScript File
 * Contains common utilities and functions used across the application
 */

// ==================== DOM Ready ====================
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
});

/**
 * Initialize application
 */
function initializeApp() {
    setupFormValidation();
    setupTableSearch();
    setupConfirmDialogs();
    setupTooltips();
    autoHideAlerts();
}

// ==================== Form Validation ====================
/**
 * Setup form validation for all forms
 */
function setupFormValidation() {
    const forms = document.querySelectorAll('form[data-validate]');

    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!validateForm(this)) {
                e.preventDefault();
                return false;
            }
        });
    });
}

/**
 * Validate a form
 * @param {HTMLFormElement} form - The form to validate
 * @returns {boolean} - Whether the form is valid
 */
function validateForm(form) {
    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            showInputError(input, 'This field is required');
            isValid = false;
        } else {
            clearInputError(input);
        }
    });

    return isValid;
}

/**
 * Show error message for an input field
 * @param {HTMLElement} input - The input element
 * @param {string} message - Error message
 */
function showInputError(input, message) {
    input.classList.add('border-red-500');

    let errorDiv = input.nextElementSibling;
    if (!errorDiv || !errorDiv.classList.contains('error-message')) {
        errorDiv = document.createElement('div');
        errorDiv.className = 'error-message text-red-500 text-sm mt-1';
        input.parentNode.insertBefore(errorDiv, input.nextSibling);
    }
    errorDiv.textContent = message;
}

/**
 * Clear error message from an input field
 * @param {HTMLElement} input - The input element
 */
function clearInputError(input) {
    input.classList.remove('border-red-500');

    const errorDiv = input.nextElementSibling;
    if (errorDiv && errorDiv.classList.contains('error-message')) {
        errorDiv.remove();
    }
}

// ==================== Table Search ====================
/**
 * Setup search functionality for tables
 */
function setupTableSearch() {
    const searchInputs = document.querySelectorAll('input[data-table-search]');

    searchInputs.forEach(input => {
        const tableId = input.getAttribute('data-table-search');
        input.addEventListener('keyup', function() {
            searchTable(tableId, this.value);
        });
    });
}

/**
 * Search table rows
 * @param {string} tableId - ID of the table to search
 * @param {string} searchTerm - Search term
 */
function searchTable(tableId, searchTerm) {
    const table = document.getElementById(tableId);
    if (!table) return;

    const filter = searchTerm.toUpperCase();
    const rows = table.getElementsByTagName('tr');

    for (let i = 1; i < rows.length; i++) {
        const cells = rows[i].getElementsByTagName('td');
        let found = false;

        for (let j = 0; j < cells.length; j++) {
            const cellValue = cells[j].textContent || cells[j].innerText;
            if (cellValue.toUpperCase().indexOf(filter) > -1) {
                found = true;
                break;
            }
        }

        rows[i].style.display = found ? '' : 'none';
    }
}

// ==================== Confirm Dialogs ====================
/**
 * Setup confirmation dialogs for delete actions
 */
function setupConfirmDialogs() {
    const deleteLinks = document.querySelectorAll('a[data-confirm], button[data-confirm]');

    deleteLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const message = this.getAttribute('data-confirm') || 'Are you sure you want to delete this item?';
            if (!confirm(message)) {
                e.preventDefault();
                return false;
            }
        });
    });
}

// ==================== Tooltips ====================
/**
 * Setup tooltips
 */
function setupTooltips() {
    const tooltipElements = document.querySelectorAll('[data-tooltip]');

    tooltipElements.forEach(element => {
        element.addEventListener('mouseenter', function() {
            showTooltip(this);
        });

        element.addEventListener('mouseleave', function() {
            hideTooltip(this);
        });
    });
}

/**
 * Show tooltip
 * @param {HTMLElement} element - Element with tooltip
 */
function showTooltip(element) {
    const text = element.getAttribute('data-tooltip');
    const tooltip = document.createElement('div');
    tooltip.className = 'tooltip-popup absolute bg-gray-900 text-white text-xs px-2 py-1 rounded shadow-lg z-50';
    tooltip.textContent = text;
    tooltip.id = 'tooltip-' + Date.now();

    document.body.appendChild(tooltip);

    const rect = element.getBoundingClientRect();
    tooltip.style.top = (rect.top - tooltip.offsetHeight - 5) + 'px';
    tooltip.style.left = (rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2)) + 'px';

    element.setAttribute('data-tooltip-id', tooltip.id);
}

/**
 * Hide tooltip
 * @param {HTMLElement} element - Element with tooltip
 */
function hideTooltip(element) {
    const tooltipId = element.getAttribute('data-tooltip-id');
    if (tooltipId) {
        const tooltip = document.getElementById(tooltipId);
        if (tooltip) {
            tooltip.remove();
        }
        element.removeAttribute('data-tooltip-id');
    }
}

// ==================== Auto Hide Alerts ====================
/**
 * Auto hide alert messages after 5 seconds
 */
function autoHideAlerts() {
    const alerts = document.querySelectorAll('.alert[data-auto-hide]');

    alerts.forEach(alert => {
        setTimeout(() => {
            fadeOut(alert);
        }, 5000);
    });
}

/**
 * Fade out an element
 * @param {HTMLElement} element - Element to fade out
 */
function fadeOut(element) {
    let opacity = 1;
    const timer = setInterval(() => {
        if (opacity <= 0.1) {
            clearInterval(timer);
            element.style.display = 'none';
        }
        element.style.opacity = opacity;
        opacity -= 0.1;
    }, 50);
}

// ==================== Utility Functions ====================
/**
 * Format date to readable string
 * @param {Date} date - Date object
 * @returns {string} - Formatted date string
 */
function formatDate(date) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
}

/**
 * Calculate grade from marks
 * @param {number} total - Total marks
 * @returns {string} - Grade letter
 */
function calculateGrade(total) {
    if (total >= 90) return 'A+';
    if (total >= 81) return 'A';
    if (total >= 73) return 'B+';
    if (total >= 65) return 'B';
    if (total >= 60) return 'C+';
    if (total >= 55) return 'C';
    if (total >= 50) return 'C-';
    return 'F';
}

/**
 * Get grade color class
 * @param {string} grade - Grade letter
 * @returns {string} - CSS color class
 */
function getGradeColor(grade) {
    if (grade.startsWith('A')) return 'green';
    if (grade.startsWith('B')) return 'blue';
    if (grade.startsWith('C')) return 'yellow';
    return 'red';
}

/**
 * Show notification
 * @param {string} message - Notification message
 * @param {string} type - Notification type (success, error, warning, info)
 */
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `fixed top-4 right-4 p-4 rounded-lg shadow-lg z-50 alert-${type}`;
    notification.textContent = message;

    document.body.appendChild(notification);

    setTimeout(() => {
        fadeOut(notification);
    }, 3000);
}

/**
 * Validate email format
 * @param {string} email - Email address
 * @returns {boolean} - Whether email is valid
 */
function isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

/**
 * Validate phone number format
 * @param {string} phone - Phone number
 * @returns {boolean} - Whether phone is valid
 */
function isValidPhone(phone) {
    const re = /^[\d\s\-\+\(\)]+$/;
    return re.test(phone) && phone.replace(/\D/g, '').length >= 10;
}

/**
 * Debounce function
 * @param {Function} func - Function to debounce
 * @param {number} wait - Wait time in milliseconds
 * @returns {Function} - Debounced function
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Copy text to clipboard
 * @param {string} text - Text to copy
 */
function copyToClipboard(text) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    textarea.style.position = 'fixed';
    textarea.style.opacity = '0';
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    showNotification('Copied to clipboard!', 'success');
}

/**
 * Export table to CSV
 * @param {string} tableId - ID of table to export
 * @param {string} filename - Output filename
 */
function exportTableToCSV(tableId, filename = 'export.csv') {
    const table = document.getElementById(tableId);
    if (!table) return;

    let csv = [];
    const rows = table.querySelectorAll('tr');

    rows.forEach(row => {
        const cols = row.querySelectorAll('td, th');
        const csvRow = [];
        cols.forEach(col => {
            csvRow.push('"' + col.textContent.trim() + '"');
        });
        csv.push(csvRow.join(','));
    });

    const csvString = csv.join('\n');
    const blob = new Blob([csvString], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    a.click();
    window.URL.revokeObjectURL(url);
}

/**
 * Print specific element
 * @param {string} elementId - ID of element to print
 */
function printElement(elementId) {
    const element = document.getElementById(elementId);
    if (!element) return;

    const printWindow = window.open('', '', 'height=600,width=800');
    printWindow.document.write('<html><head><title>Print</title>');
    printWindow.document.write('<link rel="stylesheet" href="https://cdn.tailwindcss.com">');
    printWindow.document.write('</head><body>');
    printWindow.document.write(element.innerHTML);
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    printWindow.print();
}

// ==================== Export Functions ====================
// Make functions available globally
window.DMS = {
    validateForm,
    searchTable,
    calculateGrade,
    getGradeColor,
    showNotification,
    isValidEmail,
    isValidPhone,
    copyToClipboard,
    exportTableToCSV,
    printElement,
    formatDate
};