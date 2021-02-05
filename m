Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C6310353
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Feb 2021 04:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBEDKB (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 4 Feb 2021 22:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDJ5 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 4 Feb 2021 22:09:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1BDC061797;
        Thu,  4 Feb 2021 19:08:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m13so5939544wro.12;
        Thu, 04 Feb 2021 19:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=NRTh4M0Jcl6GH1vZx6tfehzdSRsMQorZISNOE9gHFCDnJ9pKqRA7GWrfGPHC6OgQqp
         BRNYtYsNO5JT0lD1kYg6TcwP7Z8niz0b3VHWG8eQNg7Gc20C/neX86SKnRyzJOmIJrgJ
         kB5eKRBOfoFLXDnIFwo/XdUtkMV34RBU3+TE/cotaoXGm7XnE6fg74/ybaXKyAQrS3qY
         KYCwxSEiM6aUEaumxUCFfOeSc9ZItOxax77yIHpPnuIcGyYnAlYjctLHt3xL8zjfdYOc
         sI13F+PxWTL2rp7sbp/7MJQs+zHp2JuW8LQkwb22UVWHPnAHhrkt9vKPACdqHBDoQIWh
         Nbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=NVCuMvsxLp7BVimjV0Z44wx+FECULNFIqMQwdZcE6UEl5/Hm8BvbggKj0WlwfYBuz1
         Mlef7ZRLVx4u7l1cjzamBrkto5GB4BYFT8m9ZRWzfqtOoIjBRpWnxojss1VqHv6ifk9z
         FxKv/uWLIZ27L4WV8Oqyyj1MawOp+lQWhgbgVKwrhENmw8fDcXxQYPK3RDh4SyqQo78v
         oKIe4p9FoYWs0+lqERDR5mM5J+uf84a2N2xySHT+5MU3wfc8IFEN9ul8DXe4OucTw+1H
         OAQwAu7BykzxcOMMNTdgviY4kgG7jp0slY5xfCshlz/EXyb7yDis9nonYuLPIugI3TtV
         Bn+g==
X-Gm-Message-State: AOAM531w+Vh5R5NeEdnHoOFbbruK9yQu4KYVVVbM11FsFGt+MwZvU+KF
        J1njTpmimMzmwzo/FOtvcwmF+2FYWlHhGw==
X-Google-Smtp-Source: ABdhPJyPEO5lhPU5Ki3tYUdHo7/A48MpSbIv/4vddJ3dvYDTD5o8YUiYoljvt6TQN6lCHXJY1Pc/sQ==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr2470551wrg.362.1612494519670;
        Thu, 04 Feb 2021 19:08:39 -0800 (PST)
Received: from [192.168.1.6] ([154.124.28.35])
        by smtp.gmail.com with ESMTPSA id n9sm10836813wrq.41.2021.02.04.19.08.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2021 19:08:38 -0800 (PST)
Message-ID: <601cb6b6.1c69fb81.5ea54.2ead@mx.google.com>
Sender: Skylar Anderson <barr.markimmbayie@gmail.com>
From:   calantha camara <sgt.andersonskylar0@gmail.com>
X-Google-Original-From: calantha camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hi dear
To:     Recipients <calantha@vger.kernel.org>
Date:   Fri, 05 Feb 2021 03:08:31 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

do you speak Eglish
