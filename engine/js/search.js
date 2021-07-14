$(function () {
    $(document).on("click", function (event) {
        if ($(event.target).closest(".de-searcher").length === 0 || !$(".de-searcher .de-searched").html()) {
            $(".de-searcher .de-searched").fadeOut(500);
        } else {
            $(".de-searcher .de-searched").fadeIn(500);
         }
    });

    $(".de-search").on("input", "#de-search", function (event) {
        const find = $(this).val();

        if (find.trim()) {
            const search = new FormData();

            search.append("find", find);

            if ($(this).data("timer")) clearTimeout($(this).data("timer"));

            $(this).data("timer", setTimeout(function () {
                send("/api/search/", search, "POST")
                    .then((json) => {
                        let searched = $(".de-searcher .de-searched");

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

                            console.log(json);

                            searched.fadeIn(500);
                        } else {
                            searched.fadeOut(500);
                        }
                    });
                }, 700)
            );
        } else {
            $(".de-searcher .de-searched").fadeOut(500);
        }
    });
});
