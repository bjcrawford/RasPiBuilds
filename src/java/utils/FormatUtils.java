/*
 *  Author: Brett Crawford <brett.crawford@temple.edu>
 *  File:   FormatUtils.java
 *  Date:   Feb 11, 2015
 *  Desc:
 */
package utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;

/**
 * Formats various data types. 
 * 
 * Most methods wrap formatted data with an HTML <td>
 * tag. When wrapping in <td> tag, substitute "&nbsp;" 
 * (HTML non-breaking space) for empty string. If this 
 * was not done, the cell in the HTML table will not
 * show its border and usually would not look right.
 */
public class FormatUtils {

    /**
     * Converts a date object to a string of the format
     * "mm/dd/yyyy".
     * 
     * @param obj A java.util.Date object
     * @return A string containing the formatted date or
     *         an empty string if the date object is null.
     */
    public static String formatDate(Object obj) {
        if (obj == null) {
            return "";
        }
        try {
            java.util.Date dateval = (java.util.Date) obj;
            SimpleDateFormat dateformat = new SimpleDateFormat("MM/dd/yyyy");
            dateformat.setLenient(false);
            return dateformat.format(dateval);
        } catch (Exception e) {
            return "Invalid date object in FormatUtils.formatDate(): " + 
                   obj.toString() + " error: " + e.getMessage();
        }
    }

    /**
     * Converts a date object to a string of the format
     * "<td style='text-align:center'>mm/dd/yyyy</td>".
     * 
     * @param obj A java.util.Date object
     * @return A string surrounded with an HTML table data
     *         element tag containing the formatted date
     *         or a single blank space if the date object 
     *         is null.
     */
    public static String formatDateTd(Object obj) {
        String out = "<td style='text-align:center'>";
        String strDate = formatDate(obj);
        if (strDate.length() == 0) {
            out += "&nbsp;";
        } else {
            out += strDate;
        }
        out += "</td>";
        return out;
    }
    
    /**
     * Converts a date object to a string of the format
     * "h:m:s a mm/dd/yyyy".
     * 
     * @param obj A java.util.Date object
     * @return A string containing the formatted timestamp or
     *         an empty string if the date object is null.
     */
    public static String formatTimestamp(Object obj) {
        if (obj == null) {
            return "";
        }
        try {
            java.util.Date dateval = (java.util.Date) obj;
            SimpleDateFormat dateformat = new SimpleDateFormat("hh:mm:ss a MM/dd/yyyy");
            dateformat.setLenient(false);
            return dateformat.format(dateval);
        } catch (Exception e) {
            return "Invalid date object in FormatUtils.formatDate(): " + 
                   obj.toString() + " error: " + e.getMessage();
        }
    }

    /**
     * Converts a date object to a string of the format
     * "<td style='text-align:center'>h:m:s a mm/dd/yyyy</td>".
     * 
     * @param obj A java.util.Date object
     * @return A string surrounded with an HTML table data
     *         element tag containing the formatted timestamp
     *         or a single blank space if the date object 
     *         is null.
     */
    public static String formatTimestampTd(Object obj) {
        String out = "<td style='text-align:center'>";
        String strDate = formatTimestamp(obj);
        if (strDate.length() == 0) {
            out += "&nbsp;";
        } else {
            out += strDate;
        }
        out += "</td>";
        return out;
    }

    /**
     * Converts a dollar amount to a string of the format
     * "$x.xx".
     * 
     * @param obj A number representing a dollar amount
     * @return A string containing the formatted dollar
     *         amount or an empty string if the dollar
     *         amount is null
     */
    public static String formatDollar(Object obj) {
        // null gets converted to empty string
        if (obj == null) {
            return "";
        }
        BigDecimal bd = (BigDecimal) obj;
        try {
            DecimalFormat intFormat = new DecimalFormat("$###,###,###,##0.00");
            return intFormat.format(bd);
        } catch (Exception e) {
            return "bad Dollar Amount in FormatUtils:" + obj.toString() + " Error:" + e.getMessage();
        }
    }
    /**
     * Converts a dollar amount to a string of the format
     * "<td style='text-align:right'>#x.xx</td>".
     * 
     * @param obj A number representing a dollar amount
     * @return A string surrounded with an HTML table data
     *         element tag containing the formatted dollar
     *         amount or a single blank space if the dollar
     *         amount is null
     */
    public static String formatDollarTd(Object obj) {
        String out = "<td style='text-align:right'>";
        String strDollarAmt = formatDollar(obj);
        if (strDollarAmt.length() == 0) {
            out += "&nbsp;";
        } else {
            out += strDollarAmt;
        }
        out += "</td>";
        return out;
    }

    /**
     * Converts an integer to a string of the format
     * "xxx,xxx,xxx".
     * 
     * @param obj An integer
     * @return A string containing the formatted integer
     *         or an empty string if the integer is null
     */
    public static String formatInteger(Object obj) {
        if (obj == null) {
            return "";
        } else {
            try {
                Integer ival = (Integer) obj;
                DecimalFormat intFormat = new DecimalFormat("###,###,###,##0");
                return intFormat.format(ival);
            } catch (Exception e) {
                return "bad Integer in FormatUtils:" + obj.toString() + " Error:" + e.getMessage();
            }
        }
    }
    
    /**
     * Converts an integer to a string of the format
     * "<td style='text-align:right'>xxx,xxx,xxx</td>".
     * 
     * @param obj An integer
     * @return A string surrounded with an HTML table data
     *         element tag containing the formatted integer
     *         or a single blank space if the integer is null
     */
    public static String formatIntegerTd(Object obj) {
        String out = "<td style='text-align:center'>";
        String strInteger = formatInteger(obj);
        if (strInteger.length() == 0) {
            out += "&nbsp;";
        } else {
            out += strInteger;
        }
        out += "</td>";
        return out;
    }

    /**
     * Converts the given input to a string.
     * 
     * @param obj 
     * @return A string containing the given input or
     *         an empty string if the input is null
     */
    public static String formatString(Object obj) {
        if (obj == null) {
            return "";
        } else {
            return (String) obj;
        }
    }

    /**
     * Converts the given input to a string of the format
     * "<td style='text-align:left'>[input]</td>".
     * 
     * @param obj 
     * @return A string surrounded with an HTML table data
     *         element tag containing the given input or
     *         an empty string if the input is null
     */
    public static String formatStringTd(Object obj) {
        String out = "<td style='text-align:left'>";
        String str = formatString(obj);
        if (str.length() == 0) {
            out += "&nbsp;";
        } else {
            out += str;
        }
        out += "</td>";
        return out;
    }
    
    /**
     * Converts a URL to a link
     * 
     * @param obj A string containing the URL
     * @param linkName A name for the link
     * @return A string containing the HTML code
     *         for an hyperlink element
     */
    public static String formatURLtoLink(Object obj, String linkName) {
        return "<a href=\"" + formatString(obj) +
               "\" >" + linkName + "</a>";
    }
    
    public static String formatURLtoLinkTd(Object obj, String linkName) {
        String result = "<td style='text-align:center'>";
        String link = formatURLtoLink(obj, linkName);
        if (link.length() == 0) {
            result += "&nbsp;";
        }
        result += link + "</td>";
        
        return result;
    }

    /**
     * Converts an object to a string.
     * 
     * @param obj An object
     * @return A string containing the the object or
     *         an empty string if the object is null
     */
    public static String objectToString(Object obj) {
        if (obj == null) {
            return "";
        }
        try {
            return obj.toString();
        } catch (Exception e) {
            return "Exception converting object to string FormatUtils.objectToString(): " + e.getMessage();
        }
    }
}

