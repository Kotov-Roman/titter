<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="form-row mb-3">
        <form method="get" action="/main" class="form-inline d-flex flex-row">
            <input type="text" class="form-control w-25 me-2"
                   name="filter" placeholder="Search by tag" value="${filter?if_exists}">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <div>
        <a class="btn btn-primary mb-1" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample"
                aria-expanded="false" aria-controls="collapseExample">
            Add new Message
        </a>
        <div class="collapse <#if message??>show</#if>" id="collapseExample">
            <div class="form-row mb-3">
                <form class="row g-3" method="post" action="/add" enctype="multipart/form-data">

                    <div class="col-auto">
                        <input type="text" name="text" placeholder="write something"
                               value="<#if message??>${message.text}</#if>"
                               class="form-control ${(textError??)?string('is-invalid','')}">
                        <#if textError??>
                            <div class="invalid-feedback">
                                ${textError}
                            </div>
                        </#if>
                    </div>

                    <div class="col-auto">
                        <input type="text" name="tag" placeholder="tag"
                               class="form-control ${(tagError??)?string('is-invalid','')}"
                        value="<#if message??>${message.tag}</#if>">
                        <#if tagError??>
                            <div class="invalid-feedback">
                                ${tagError}
                            </div>
                        </#if>
                    </div>

                    <div class="col-auto">
                        <div class="custom-file">
                            <input type="file" name="file" class="form-control" id="customFile">
                        </div>
                    </div>

                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary">Add</button>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </div>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-md-4 g-4">


        <#list messages as message>
            <div class="col">
                <div class="card my-1 h-100">
                    <#if message.filename??>
                        <img src="/img/${message.filename}" class="card-img-top"/>
                    </#if>
                    <div class="card-body">
                        <div class="d-flex flex-column mb-1">
                            <i class="mb-2">${message.tag}</i>
                            <span>${message.text}</span>
                        </div>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">${message.authorName}</small>
                    </div>
                </div>
            </div>
        <#else>
            <div class="col">
                <p>No messages</p>
            </div>
        </#list>
    </div>
</@c.page>
