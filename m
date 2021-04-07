Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCC0357685
	for <lists+linux-sctp@lfdr.de>; Wed,  7 Apr 2021 23:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhDGVOH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 7 Apr 2021 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhDGVOE (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 7 Apr 2021 17:14:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CFBC061760
        for <linux-sctp@vger.kernel.org>; Wed,  7 Apr 2021 14:13:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e12so6363812wro.11
        for <linux-sctp@vger.kernel.org>; Wed, 07 Apr 2021 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lki9sQAurZVQVXRMPUz0tFS1Yxk6SLn7E4bNd69pVl8=;
        b=s4OxENzjAFik0sS29RqtJ/TmXENrI07OkfZqjeahmvWR0TFc+wuZbihyd+4Y2mkFaM
         pPpD9Ij8Y8U2xxl6KJ+FrNdwF1uyX1037mJlXk22tzlIez1+chUakKUmHJSEDTG9U208
         JbfC0ybzMW+p8nvonsqvpoAmVnIYT/e9d2+jV6lxau1HABLZ5ku6wagjCy7mOUl9btYn
         nX/KPPG3U8MA8dvWFiXtJw48j1nvT6oAKJQwRBfzyfaY1jJTiIBwbIv4vBMqsJLkQY/T
         dX6f8tCtMQ3XXb824dyMgUfr3xMXnNlxsMIOm0J+zXsNdO+teeb0hLIyVzH/s5Ml+rN8
         Aq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lki9sQAurZVQVXRMPUz0tFS1Yxk6SLn7E4bNd69pVl8=;
        b=dx7IKLHMgx2uW5uMHz9mRtL6WaZ29LlyW77RM647pWYAohpyYB4Y1ng7YVv961xDJd
         HewtvlakviG+KSuWz5ZUZ/9iKkma1oQ2n+dw2dsYR02mphLQrnav8bStSK/IpJFHf2sf
         7POr9NwGBRb5lV/OveL2kVRV3ThSDNh7HDJFHjcstjYgQiN0zV4+11qkVSY8wYGMXvE/
         8F+61r8n2yGcCSeAeUnYqaDOSLQfpAFVSKNPwGwavPjk5Q3eYYLmZArZVnTH5PnbedLS
         lJOHl6UOSaingy1lwPBseeDdEWqcOwbvOVjl6cnSUdRmOdu1Hi/GN6C3/2uY6g96SjPT
         zknA==
X-Gm-Message-State: AOAM531AkzLVF+4yzg2JXN7GfOMFmsUu4P7B1E3P2h+lsGccvdwgFITf
        rMPhgb/5u3B2nuuXRN9eHWVH6k2ck9n9Us2Tn4w=
X-Google-Smtp-Source: ABdhPJzElibLlsga5cyRaQuy0b2R1E+1pvy/K4mMM5WJlA8KY1B8n/JYipjJVBVG5bMIoN8RI64LjX9vqUg2OqPN4E8=
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr6748401wrt.243.1617830032843;
 Wed, 07 Apr 2021 14:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <ce238aa27d414e3a6f857491d789dbfe2f1f912f.1617721194.git.marcelo.leitner@gmail.com>
In-Reply-To: <ce238aa27d414e3a6f857491d789dbfe2f1f912f.1617721194.git.marcelo.leitner@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 7 Apr 2021 17:13:41 -0400
Message-ID: <CADvbK_cnKdQftMNmwvgD_RrBA17OTuFNdqKGPaYcZPUrpQx6Dg@mail.gmail.com>
Subject: Re: [PATCH lksctp-tools] func_tests: fix malloc size in test_1_to_1_connectx.c
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Apr 7, 2021 at 1:35 AM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> Recent gcc started tracking this and now it's warning:
> test_1_to_1_connectx.c: In function =E2=80=98main=E2=80=99:
> test_1_to_1_connectx.c:133:17: warning: array subscript =E2=80=98struct s=
ockaddr[0]=E2=80=99 is partly outside array bounds of =E2=80=98unsigned cha=
r[15]=E2=80=99 [-Warray-bounds]
>   133 |         tmp_addr->sa_family =3D AF_INET;
>       |                 ^~
> test_1_to_1_connectx.c:132:40: note: referencing an object of size 15 all=
ocated by =E2=80=98malloc=E2=80=99
>   132 |         tmp_addr =3D (struct sockaddr *) malloc(sizeof(struct soc=
kaddr) - 1);
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>
> It gets parsed by __connectx_addrsize using each family struct, but they
> aligned to sockaddr size. So lets fix it here by allocating the right
> size.
>
> Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> ---
>  src/func_tests/test_1_to_1_connectx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/func_tests/test_1_to_1_connectx.c b/src/func_tests/test_=
1_to_1_connectx.c
> index 3cb18b3aad421720e8598e9a0bbab2de987d4467..9adab2352c09d0fb0087e4c4b=
43c6d7d7b60de0d 100644
> --- a/src/func_tests/test_1_to_1_connectx.c
> +++ b/src/func_tests/test_1_to_1_connectx.c
> @@ -129,7 +129,7 @@ main(int argc, char *argv[])
>         tst_resm(TPASS, "sctp_connectx() with invalid socket - ENOTSOCK")=
;
>
>         /*sctp_connectx () TEST3: Invalid address, EINVAL Expected error*=
/
> -       tmp_addr =3D (struct sockaddr *) malloc(sizeof(struct sockaddr) -=
 1);
> +       tmp_addr =3D (struct sockaddr *) malloc(sizeof(struct sockaddr));
>         tmp_addr->sa_family =3D AF_INET;
>         error =3D sctp_connectx(sk, tmp_addr, 1, NULL);
>         if (error !=3D -1 || errno !=3D EINVAL)
> --
> 2.30.2
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
