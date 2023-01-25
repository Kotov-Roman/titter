<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="row mb-3">
            <label for="username" class="col-sm-2 col-form-label">User Name:</label>
            <div class="col-sm-3">
                <input type="text"
                       class="form-control <#if usernameError??>is-invalid</#if>"
                       value="<#if user??>${user.username}</#if>"
                       name="username" placeholder="User name">
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="row mb-3">
            <label for="password" class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-3">
                <input type="password" class="form-control <#if passwordError??>is-invalid</#if>"
                       name="password" placeholder="Password">
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>

        <#if isRegisterForm>
            <div class="row mb-3">
                <label for="confirmationPassword" class="col-sm-2 col-form-label">Confirmation Password:</label>
                <div class="col-sm-3">
                    <input type="password" class="form-control <#if confirmationPasswordError??>is-invalid</#if>"
                           name="confirmationPassword" placeholder="Confirmation Password">
                    <#if confirmationPasswordError??>
                        <div class="invalid-feedback">
                            ${confirmationPasswordError}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="row mb-3">
                <label for="email" class="col-sm-2 col-form-label">Email:</label>
                <div class="col-sm-3">
                    <input type="email" class="form-control <#if emailError??>is-invalid</#if>"
                           value="<#if user??>${user.email}</#if>"
                           name="email" placeholder="some@mail.com">
                    <#if emailError??>
                        <div class="invalid-feedback">
                            ${emailError}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="g-recaptcha" data-sitekey="6LdDEiQkAAAAAOC5L9faGy0LbNhTgqhYydrJ--82"></div>
                <#if captchaError??>
                    <div class="alert alert-danger" role="alert">
                        ${captchaError}
                    </div>
                </#if>
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
