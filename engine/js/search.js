$(function () {
    $(document).on("click", function (event) {
        if ($(event.target).closest(".de-searcher").length === 0 || !$(".de-searcher .de-searched").html()) {
            $(".de-searcher .de-searched").removeClass('open');
        } else {
            $(".de-searcher .de-searched").addClass('open');
         }
    });

    $(".de-search").on("input", "#de-search", function (event) {
        const find = $(this).val();
        const searched = $(".de-searcher .de-searched");

        if (find.trim() !== "") {
            const search = new FormData();

            search.append("find", find);

            if ($(this).data("timer")) clearTimeout($(this).data("timer"));

            $(this).data("timer", setTimeout(function () {
                send("/api/search/", search, "POST")
                    .then((json) => {

                        searched.empty();

                        if (json) {
                            for (let tovar of json) {
                                let view = $(
                                    `
                                    <a href="/tovars/${tovar.id}/">
                                        <img src="/${tovar.poster}" alt="${tovar.name}" class="search__poster">
                                        <div class="search__info">
                                            <div class="search__name">${tovar.name}</div>
                                            <div class="search__price">` 
                                            + (tovar.discount != 0
                                                ? `<span class="discount">${tovar.discount} руб. <span class="price">${tovar.price} руб.</span></span> `
                                                : `<span class="price">${tovar.price} руб.</span>`
                                            ) +
                                            `</div>
                                        </div>
                                    </a>
                                `
                                );
                                searched.append(view);
                            }

                            searched.addClass('open');
                        } else {
                            searched.removeClass('open');
                        }
                    });
                }, 1000)
            );
        } else {
            searched.removeClass('open');
            searched.empty();
        }
    });
});
