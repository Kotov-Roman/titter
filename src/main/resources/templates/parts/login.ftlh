<#macro login path isRegisterForm>
    ${message?if_exists}
    <form action="${path}" method="post">
        <div class="row mb-3">
            <label for="username" class="col-sm-2 col-form-label">User Name:</label>
            <div class="col-sm-3">
                <input type="text" class="form-control" name="username" placeholder="User name">
            </div>
        </div>
        <div class="row mb-3">
            <label for="password" class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-3">
                <input type="password" class="form-control" name="password" placeholder="Password">
            </div>
        </div>
        <#if isRegisterForm>
            <div class="row mb-3">
                <label for="email" class="col-sm-2 col-form-label">Email:</label>
                <div class="col-sm-3">
                    <input type="email" class="form-control" name="email" placeholder="some@mail.com">
                </div>
            </div>
        </#if>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <#if !isRegisterForm>
            <div class="row mb-3">
                <a href="/registration">Registration</a>
            </div>
        </#if>
        <button type="submit" class="btn btn-primary"><#if isRegisterForm>Create<#else>Sign in</#if></button>
    </form>

</#macro>
<#macro logout path>

    <form action="/logout" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Sign out</button>

    </form>
</#macro>
