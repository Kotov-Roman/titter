<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
    <p> Add new User:</p>
    <@l.login "/registration"></@l.login>
</@c.page>