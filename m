Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042F52B0CF
	for <lists+linux-sctp@lfdr.de>; Wed, 18 May 2022 05:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiERDdg (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 17 May 2022 23:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiERDd3 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 17 May 2022 23:33:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EDF8DDD6
        for <linux-sctp@vger.kernel.org>; Tue, 17 May 2022 20:33:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so797682pga.13
        for <linux-sctp@vger.kernel.org>; Tue, 17 May 2022 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7ufMN0FvzjDOXYwU0/TRVVJ4gfg3aiZa2NlDLfkxEbc=;
        b=E0GbyjhmMQbskTA4oNB+pMXxPwJ2mnju8EKWwPl/6Mjoj3djAhoZe/yvITYRrsGIog
         v9jUnBDI+/f/gELjiaiolUdHY/JDoNFOcDR4TSCYnIxWZF+l6NRicyZX74yLpL4Yp/Yq
         UEOsEUC9th8asTuoOsQvlYUrx5+y7V40lcVqlE+JAQyIzRrJ7fgJj2chdAm6hl82I7BQ
         koc2Lu0DTw4RbDnPj1F+GBMfv7VUDec/btLBb3gudYfpcZVULPoyyjSAZp29lPLIN2du
         2QbpvvnOEgYD+MAaC+12VF9fqzWUqxU9t/vCMmlGEbsb6AU++3Bc8jBhnGMruF8HtszL
         8dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7ufMN0FvzjDOXYwU0/TRVVJ4gfg3aiZa2NlDLfkxEbc=;
        b=zGQK1XazCgJSzkqJwsa2tynFC36I2G96j5+u5fJWlEopVMUSWS2g75rgfjqfUAOmCR
         rhFwOTf5svPloK7LSzm3fiquMNWwnEPJ0FBRbSXOYvJhuBPofMlzMJzewPTzaAm9oLGB
         yJEweP9v4tXWxbKJ1Aypm1G+SY9Lkn8ljK4DbvHZpISoWYlHtJ5CTUBvWGXSg0Hoza0q
         lMytm0S0/Gkp2gUwt3j+uXOfNlYPBMO9aalPuGnJPeE1bP2+edKMl63dF/L36AqHK1/h
         MsD8AJEcEXebmTun8dXAUOY1irThUI5r3+0un+368nyhSHP0jWWNdEbmLOxROZPRN581
         INVA==
X-Gm-Message-State: AOAM531g23IpDxOs9nsUnR8aBOUGrvtF+zfr95rZVkF59XJV1IGa+gfr
        N309zvCFrUMYFlMTwh7lOYzpJzX3oe5Sf2ZjW9o=
X-Google-Smtp-Source: ABdhPJx8R6RBGxl78L/URzg6D9FfCg5oe9wDVMcdVLEusQOmTDvkr3xhQg04GQ4HffOzFI1NOjAmuPty8vVqUMgdmkQ=
X-Received: by 2002:a65:4c41:0:b0:3f5:cf9f:283b with SMTP id
 l1-20020a654c41000000b003f5cf9f283bmr4393620pgr.301.1652844807949; Tue, 17
 May 2022 20:33:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:9c1d:b0:28e:5ca9:b99a with HTTP; Tue, 17 May 2022
 20:33:27 -0700 (PDT)
Reply-To: mrstheresaheidi8@gmail.com
From:   Ms Theresa Heidi <thereheid02@gmail.com>
Date:   Tue, 17 May 2022 20:33:27 -0700
Message-ID: <CAPcJwaUZY4RN5NSMxEmZU=o4RPDm_+NzyvNmeJLsysXEHHiVew@mail.gmail.com>
Subject: =?UTF-8?B?6ri06riJIOyDge2ZqSDrj4Tsm4Ah?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

7J6Q7ISgIOq4sOu2gCENCg0K7KO87J2YIOq5iuqyjCDsnb3snLzsi63si5zsmKQuIOydtCDtjrjs
p4DqsIAg64u57Iug7JeQ6rKMIOuGgOudvOybgOycvOuhnCDsmKwg7IiYIOyeiOydjOydhCDslYzq
s6Ag7J6I7Iq164uI64ukLiDqt4DtlZjsnZgg64+E7JuA7J20IO2VhOyalO2VnCDrj5nslYgg6rCc
7J24IOqygOyDieydhA0K7Ya17ZW0IOq3gO2VmOydmCDsnbTrqZTsnbwg7Jew65297LKY66W8IOuw
nOqyrO2WiOyKteuLiOuLpC4g66eI7J2M7IaNIOq5iuydgCDsiqztlJTsnYQg7JWI6rOgIOydtCDt
jrjsp4Drpbwg7JSB64uI64ukLiDsnbjthLDrhLfsnbQg7Jes7KCE7Z6IIOqwgOyepSDruaDrpbgg
7Ya17IugDQrsiJjri6jsnbTquLAg65WM66y47JeQIOyduO2EsOuEt+ydhCDthrXtlbQg7Jew6529
7ZWY6riw66GcIOqysOygle2WiOyKteuLiOuLpC4NCg0K7KCA64qUIO2YhOyerCA2MuyEuOydmCDt
hYzroIjsgqwg7ZWY7J2065SUKFRoZXJlc2EgSGVpZGkpIOyXrOyCrOyeheuLiOuLpC4g7ZiE7J6s
IO2PkOyVlOycvOuhnCDsnbTsiqTrnbzsl5jsnZgg7ZWcIOyCrOumvSDrs5Hsm5Dsl5Ag7J6F7JuQ
7ZW0DQrsnojsirXri4jri6QuIOyggOuKlCA064WEIOyghCDtj5DslZQg7KeE64uo7J2EIOuwm+yV
mOyKteuLiOuLpC4g64Ko7Y647J2AIOuCqO2OuOydtCDqsIDsp4Qg66qo65OgIOqyg+ydhCDsoIDs
l5Dqsowg64Ko6rKo65GQ6rOgIOyEuOyDgeydhCDrlqDrgpwg7KeB7ZuE7JiA7Iq164uI64ukLg0K
64KY64qUIO2PkOyVlCDsuZjro4zrpbwg67Cb6rOgIOyeiOuKlCDrs5Hsm5Dsl5DshJwg64W47Yq4
67aB7J2EIOuTpOqzoCDsnojsirXri4jri6QuDQoNCuuCmOuKlCDrj4zslYTqsIDsi6Ag64Ko7Y64
7JeQ6rKMIOusvOugpOuwm+ydgCDquLDquIjsnbQgMjUw66eMIOuLrOufrOyXkCDrtojqs7ztlanr
i4jri6QuIOydtOygnCDrgrQg7J247IOd7J2YIOuniOyngOuniSDrgqDsnbQg64uk6rCA7Jik6rOg
IOyeiOuLpOuKlCDqsoPsnbQNCuu2hOuqhe2VtOyhjOyKteuLiOuLpC4g7J20IOuPiOydgCDrjZQg
7J207IOBIO2VhOyalO2VmOyngCDslYrri6Tqs6Ag7IOd6rCB7ZWp64uI64ukIC4g7J2Y7IKs64qU
IOuCtOqwgCDtj5DslZTsnLzroZwg7J247ZW0IDHrhYQg64+Z7JWIIOuyhO2LuCDsiJgg7JeG64uk
64qUIOqyg+ydhA0K7J207ZW07ZWY6rKMIO2WiOyKteuLiOuLpC4NCg0K7J20IOuPiOydgCDsl6zs
oITtnogg4oCL4oCL7Jm46rWtIOydgO2WieyXkCDsnojqs6Ag6rK97JiB7KeE7J2AIOuCtOqwgCDs
p4jrs5HsnLzroZwg7J247ZW0IOyYrCDsiJgg7JeG6riwIOuVjOusuOyXkCDrj4jsnYQg67Cb6riw
IOychO2VtCDslZ7snLzroZwg64KY7Jik6rGw64KYIOyYpO2eiOugpA0K64KY66W8IOuMgOyLoO2V
mOyXrCDsiJjroLkg7ZWgIOyImCDsnojrj4TroZ0g7Iq57J247ISc66W8IOyLpOygnCDshozsnKDs
npDroZwg7J6R7ISx7ZaI7Iq164uI64ukLiAuIOydgO2WieydtCDsobDsuZjrpbwg7Leo7ZWY7KeA
IOyViuydhCDqsr3smrAg7J6Q6riI7J2EIOuEiOustCDsmKTrnpgNCuuztOq0gO2VmOuptCDrqrDs
iJjrkKAg7IiYIOyeiOyKteuLiOuLpC4NCg0K64u57Iug7J20IOyZuOq1rSDsnYDtlonsl5DshJwg
7J20IOuPiOydhCDsnbjstpztlZjripQg642wIOuPhOybgOydtCDrkJjqs6Ag6rSA7Ius7J20IOye
iOuLpOuptCDsl7Drnb3tlZjquLDroZwg6rKw7KCV7ZaI7Iq164uI64ukLiDqt7jrn7Ag64uk7J2M
IOq4sOq4iOydhCDsnpDshKAg7Zmc64+Z7JeQDQrsgqzsmqntlZjsl6wg7IaM7Jm465CcIOyCrOue
jOuTpOydhCDrj5XquLDroZwg7ZaI7Iq164uI64ukLiDrgpjsl5Dqsowg66y07IqoIOydvOydtCDs
nbzslrTrgpjquLAg7KCE7JeQIOydtCDsi6Dtg4Eg6riw6riI7J2EIOyEoOydmOuhnCDsspjrpqzt
lZjquLDrpbwg67CU656N64uI64ukLiDsnbTqsoPsnYANCuuPhOuCnOuLue2VnCDrj4jsnbQg7JWE
64uI66mwIOq0gOugqOuQnCDsnITtl5jsnbQg7JeG7Jy866mwIOyZhOyghO2VnCDrspXsoIEg7Kad
6rGw7JmAIO2VqOq7mCAxMDAlIOychO2XmOydtCDsl4bsirXri4jri6QuDQoNCuuCmOuKlCDri7ns
i6DsnbQg64u57Iug7J2YIOqwnOyduCDsgqzsmqnsnYQg7JyE7ZW0IOy0nSDrj4jsnZggNDUl66W8
IOqwgOyguOqwgOqzoCDrj4jsnZggNTUl66W8IOyekOyEoCDsgqzsl4Xsl5Ag7IKs7Jqp7ZWY6riw
66W8IOuwlOuejeuLiOuLpC4g64KY64qUIOuCtA0K66eI7KeA66eJIOyGjOybkOydhCDsnITtg5zr
oa3qsowg7ZWgIOyWtOuWpCDqsoPrj4Qg7JuQ7ZWY7KeAIOyViuq4sCDrlYzrrLjsl5Ag64K0IOun
iOydjOydmCDshozsm5DsnYQg7J2066Oo6riwIOychO2VtCDsnbQg66y47KCc7JeQIOuMgO2VtCDs
tZzrjIDtlZzsnZgg7Iug66Kw7JmAIOu5hOuwgOydhA0K7Jyg7KeA7ZW0IOyjvOyFlOyEnCDqsJDs
gqztlanri4jri6QuIOyKpO2MuOycvOuhnCDsnbQg7Y647KeA66W8IOuwm+ycvOyFqOuLpOuptCDr
jIDri6jtnogg7KOE7Iah7ZWp64uI64ukLiDstZzqt7wg7J206rOzIOq1reqwgOyXkOyEnCDsoJHs
ho0g7Jik66WY6rCAIOuwnOyDne2WiOq4sA0K65WM66y47J6F64uI64ukLg0KDQrri7nsi6DsnZgg
7IKs656R7ZWY64qUIOyekOunpC4NCu2FjOugiOyCrCDtlZjsnbTrlJQg67aA7J24DQo=
