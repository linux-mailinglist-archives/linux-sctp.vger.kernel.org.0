Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC6B593AB2
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Aug 2022 22:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiHOUWv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 15 Aug 2022 16:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbiHOUWM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 15 Aug 2022 16:22:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F733A22
        for <linux-sctp@vger.kernel.org>; Mon, 15 Aug 2022 12:02:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so2278655otr.4
        for <linux-sctp@vger.kernel.org>; Mon, 15 Aug 2022 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wXN27groTpzUWBkE7W9ylNpUQgGI8M5oZ1s0kCgJ9Bc=;
        b=E6+S7PvoZOEqwGq1BaC1qYbg9rUk982CkNjMRYF+wMgmKEsZqEXJoPfZgvnx314yd3
         yh8jRq0JDH8Iel4WKWRrK42g+SmmgE4EuHs7OgOsOpBBWDd3DrlPBOQ1ZRLa0SNscQkF
         E10OqGlLAqw1IgdxxvtBI8DHJC9qtr+X284pRBoYb1tq9VFLUu7mJMVw/dqufMw9WCXl
         +gvwGxUDLoD6nKyJcJQ8Kgw0GpC0mh2U8uyF18PCLnVrlcmUZssULS5Kl5d599DlXey9
         d6rmtvguzraJkL6oT7P6uzexaqnnyBbG2jjgMPj17bBOxY+OgT00+gtTciyTKxQV/Oi/
         yTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wXN27groTpzUWBkE7W9ylNpUQgGI8M5oZ1s0kCgJ9Bc=;
        b=aAHmy/jiSqqvTsC66Cs1RADxoiBFipc+Bm4KpdG9fG5lPopr3e8AOJ2xMp1I/6SN9k
         oME4pmAN60qz+L0qJie5gkoJL3XdZmqVn1j7Xi4E20zxMhD3gGiKfml1fiWyWdh2i+JU
         gwgiX98ueIeX8sMkaWMPfKIyouTEZJa84TGzZtQc7W5YS1X+cX12nGiIMir0N+4Pltv1
         aJMrsT/3S51L7P4ngY7T43oMPU++CyJ53npA+vE2ci8jfitu2745ByXyxFEHQr2xkB/L
         1KkkG0l6Sy9CW2dJLHBlhHnCEZNMOnxagZ2BAjTnkxVLf1WWmycqVm18Yl86lVJgnj9P
         ZVpQ==
X-Gm-Message-State: ACgBeo104vg8umWWQ6O4KsnS6zRsLuP0c8kqysLnOKLowBAioPf7zEUo
        G8aehGExFpVnuf6NV07z/Nuj6JAIUSNEtTaED+o=
X-Google-Smtp-Source: AA6agR4p3onsoUBPG6QdS2YA8isMbegFQEHGh/wR0VqOT4KfAcfUJW5rpPwEs7rHocqr/fBZ14iEWiwt49Yck9bDM2I=
X-Received: by 2002:a05:6830:2787:b0:60c:33b4:f374 with SMTP id
 x7-20020a056830278700b0060c33b4f374mr6158245otu.295.1660590120756; Mon, 15
 Aug 2022 12:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154351.27646-1-luoyuxuan.carl@gmail.com>
In-Reply-To: <20220805154351.27646-1-luoyuxuan.carl@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 15 Aug 2022 15:00:53 -0400
Message-ID: <CADvbK_eohNoZwRYrUmXy=e0dxMohJJtkdwcAO+9nbby6dhq9EA@mail.gmail.com>
Subject: Re: [PATCH lksctp-tools 0/2] func_tests: Add test cases for
 interleaving and stream RE_CONFIG
To:     Yuxuan Luo <luoyuxuan.carl@gmail.com>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Yuxuan Luo <yuluo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Aug 5, 2022 at 11:44 AM Yuxuan Luo <luoyuxuan.carl@gmail.com> wrote:
>
> Add two test cases for verifying the support
> for interleaving and re_config recently implemented in kernel.
>
> Signed-off-by: Yuxuan Luo <luoyuxuan.carl@gmail.com>
>
> Yuxuan Luo (2):
>   Add a test case for interleaving
>   Add a test cacse for RE_CONFIG
>
>  configure.ac                     |   3 +
>  src/func_tests/.gitignore        |   4 +
>  src/func_tests/Makefile.am       |  20 +++
>  src/func_tests/test_interleave.c | 254 +++++++++++++++++++++++++++++++
>  src/func_tests/test_re_conf.c    | 251 ++++++++++++++++++++++++++++++
>  5 files changed, 532 insertions(+)
>  create mode 100644 src/func_tests/test_interleave.c
>  create mode 100644 src/func_tests/test_re_conf.c
>
> --
> 2.37.1
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
