Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5474441E9
	for <lists+linux-sctp@lfdr.de>; Wed,  3 Nov 2021 13:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhKCMxa (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 3 Nov 2021 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhKCMx3 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 3 Nov 2021 08:53:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454AC061714
        for <linux-sctp@vger.kernel.org>; Wed,  3 Nov 2021 05:50:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so8885549edj.1
        for <linux-sctp@vger.kernel.org>; Wed, 03 Nov 2021 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Pmx5dMS/sfvj+Kx+WtUsbkLY0X876q84Mr0oV/bmMHs=;
        b=p0jszQb7wXhYA4aQ6qKjhNrVHrlOfcnwuyB9Lu6RiLa3GaW/J50zCApmG8vtSYxZKA
         vxUXVupwmPp3twsmfGcmp2eJppnw4mYiwYX6QFU0Nl4XHOm0Cx+HXIl/O8UISJmLcDdl
         IhBWXgp1gL17yno/QNtGyhZnu6Ff/yTpXx+hLaeknokjxpWnix5w6qc6e/ogYo7GdTC9
         IhifMqgeajitAhyDKkSXrnk/v7WCvnpE12EUk45tPlVYixHxtdr172u4bT4T1h+rPcn0
         h7OuahG2Le0SancRqwIDEEoXfjaM+bunMuMVNvtHHwFw0SJ+9eWjPSE9rsqojjhJNYXP
         4JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Pmx5dMS/sfvj+Kx+WtUsbkLY0X876q84Mr0oV/bmMHs=;
        b=qPcZ9xrm7yfvJKIrE5fFZ1YpBODCgqquUH3ct+WSzSYb5Rl29HfJVHDYqovHGn2epP
         7QRfWm/VeIFUPOv4Ou3q48s07Gh68s40DAduJl9OAlsIv2kYUh2FkeYO+DAQL9DjtM5B
         +WtIPt7Pi9gJr9pUd9ccsQIDf5JEmGX2uzD0Q1lu8J6lsYBTYFU41UmvjuFO2SP4TuQP
         skJht4pGACR0XDnxVZbVwGbqvuegOlIYVUaw6vUIfXvEnOmDZLc8r1aHKCrvVD9Ya9g4
         77PBE89keK4w5Qylb7KDPdbRdz0jm3rYkz9wEg2/Iw1u6VsdqgOdD0k3TSQomMBU+WfN
         20NA==
X-Gm-Message-State: AOAM533OTDiBXyFMA+mntWQK9paeUIlyfpT6sMmkh5BGBNUeDF3b6tAs
        Y5gpZsnr+0tMLAjy85ZwR+n8R7HRZp3zUbw2n68=
X-Google-Smtp-Source: ABdhPJyNQ/OEDYtl3jnHckXCBL4W5QvzN6Y2/STywnzfKXsPgBj0tfpGQA9lMRtJvBqe4H3YglwBGMBJWk0GwYxgeAk=
X-Received: by 2002:a17:906:2a5a:: with SMTP id k26mr10159144eje.135.1635943851131;
 Wed, 03 Nov 2021 05:50:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:370b:0:0:0:0 with HTTP; Wed, 3 Nov 2021 05:50:50
 -0700 (PDT)
Reply-To: catherienewenzel@nifty.com
From:   Catherine Wenzel <ministere.soutien@gmail.com>
Date:   Wed, 3 Nov 2021 13:50:50 +0100
Message-ID: <CAMTz8rQftVKCFE-pEK4uZQX_uuEsUy7rEynjGpTLi6OQHnb18g@mail.gmail.com>
Subject: =?UTF-8?B?LS0gUmU6IE1laW5lIGJlc3RlbiBHcsO8w59l?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Lieber Freund,
M=C3=B6ge GOTT Sie segnen, dass Sie auf meine Botschaft achten.
Ich schreibe Ihnen diesen Brief aus dem Krankenhaus, weil ich jetzt
sehr krank bin.
Ich habe eine riesige Menge Geld, 5.000.000,00 Dollar, um es an die
Weniger zu spenden
privilegiert, bevor ich sterbe. Ich habe Angst, dass ich diese
Krankheit nicht =C3=BCberleben k=C3=B6nnte.
Meine Absicht ist es, mit dem Geld eine Wohlt=C3=A4tigkeitsstiftung zu
gr=C3=BCnden, aber mein Gesundheitszustand ist jetzt sehr schlecht.
Aus diesem Grund ben=C3=B6tige ich Ihre Hilfe, um die
Wohlt=C3=A4tigkeitsstiftung in meinem Namen zu verwalten.
Ich werde meine Bank anweisen, das Geld auf Ihr Konto zu =C3=BCberweisen,
um dieses Projekt in meinem Namen zu starten.
Ich erz=C3=A4hle dir mehr =C3=BCber mich und meine Pl=C3=A4ne, wenn du bere=
it bist
mir zu helfen
Frau Catherine Wenzel.
