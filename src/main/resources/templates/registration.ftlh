<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
    <p> Add new User:</p>
    ${message}
    <@l.login "/registration"></@l.login>
</@c.page>