Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFC311DFC
	for <lists+linux-sctp@lfdr.de>; Sat,  6 Feb 2021 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBFOwT (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 6 Feb 2021 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBFOwS (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 6 Feb 2021 09:52:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D90C061786
        for <linux-sctp@vger.kernel.org>; Sat,  6 Feb 2021 06:51:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hs11so17698286ejc.1
        for <linux-sctp@vger.kernel.org>; Sat, 06 Feb 2021 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=s8lW6YZWnvUK7Tvlt1e2xFgpS0A6CWOUAqjS+VtrtIak+UPdQ+7l+J3tP9UY5/KPS+
         KEWFn4n6pllGZyrmGfSKElYIwDAKdjc2fmkMPe3ult5JJeZRuMDXiNsKbmA9mOrO+1Ow
         V7G4xUZDBnJ1aF8lRuT9QFBbuDAyoV826qXGwnR1cPhR1hUo5PlVP7FHbHVjqnpB1GNP
         eliTpXHEcIvx4uKGmK0JVzb3zQtQqfYXrL9q0JL/YTDEwu9TpmPAzNKmjQcQLlJ35puk
         IpQ0mnN3Y5fPfNw5DevPEtHyquTKjCJI6MS758lOeTIDhLZl9lewdpZFN272Iq+rLlU2
         +Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=NrW4KM8ko2DxEcj2ROXDz6LOiRjE+eYqXKZBsYV9ZhmnpIh0GPl7s0TfL/5qmw2spk
         uWBq3tnNvl9s4epu8BcIbQg1n89SIP6D7l+KH+slbwom169W3zmN4H/LJSpKHqLQ10gu
         nPHyMS531uAf731a/1ofKFqL32h2zBqZ5ZUZY54addXBDg4oHBYC9+boMRIjCAWU2XBm
         9lsfgnBOD+0c8vxLLk51+dx/LZ1vKSbw/Rp8mVo3mw+V7vctBHca9D9dXQWBQwfThm5s
         0+rDCfUvYODS0lD3C59pSIvCc7pawuI3J5K73SbrHBjyP+LnJwH/XwvBNRSLieBMQlXi
         re3A==
X-Gm-Message-State: AOAM533nBdKMqOCnYY27riUdXVlaoBSgPRG6+1jTBRdtLx4uMZ0BIi9m
        nqF3B1EDh/UDBeTHLd98ivO30PtsfBQHNpEA0lA=
X-Google-Smtp-Source: ABdhPJwKEibhtua8jTuLbkBXVOL+X0gFUYDNhWkJcrYB4bgtGKQCxUaLyaNWtnL7GvNWrjzndLfBs0zluDayTyISYGM=
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr8910361ejb.525.1612623093139;
 Sat, 06 Feb 2021 06:51:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:51:32
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:51:32 +0100
Message-ID: <CAGSHw-CwdZ7cob1JzomFz5dqEbMJRqn_+22Z35dNjvLGM3a-tg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
