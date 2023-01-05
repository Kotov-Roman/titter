<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>

    <p>Login page</p>
    <@l.login "/login" ></@l.login>
    <a href="/registration">Registration</a>
</@c.page>