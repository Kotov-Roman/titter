<#import "parts/common.ftlh" as c>
<@c.page>
    <h5>${username}</h5>
    ${message?if_exists}

    <form method="post">
        <div class="row mb-3">
            <label for="password" class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-3">
                <input type="password" class="form-control" name="password" placeholder="Password">
            </div>
        </div>
            <div class="row mb-3">
                <label for="email" class="col-sm-2 col-form-label">Email:</label>
                <div class="col-sm-3">
                    <input type="email" class="form-control" name="email" placeholder="some@mail.com" value="${email!''}">
                </div>
            </div>


        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>


</@c.page>